#!/usr/bin/env fish
#
# bootstrap installs everything.
#
# On a brand-new Mac run ./setup.sh instead: it installs Homebrew and the
# Brewfile (which provides fish and stow) and then runs this script.
# After that, re-run this script whenever the repo changes.

set DOTFILES_ROOT (pwd -P)

function info
	echo [(set_color --bold) ' .. ' (set_color normal)] $argv
end

function user
	echo [(set_color --bold) ' ?? ' (set_color normal)] $argv
end

function success
	echo [(set_color --bold green) ' OK ' (set_color normal)] $argv
end

function abort
	echo [(set_color --bold yellow) ABRT (set_color normal)] $argv
	exit 1
end

function on_exit -p %self
	if not contains $argv[3] 0
		echo [(set_color --bold red) FAIL (set_color normal)] "Couldn't setup dotfiles, please open an issue at https://github.com/ronenh/dotfiles"
	end
end

function install_brewfile
	if not command -q brew
		info "brew not found, skipping Brewfile (run ./setup.sh to install Homebrew)"
		return 0
	end
	# Fast path: nothing to do when every Brewfile entry is already installed.
	if brew bundle check --file=$DOTFILES_ROOT/Brewfile --no-upgrade >/dev/null 2>&1
		info "Brewfile already satisfied"
		return 0
	end
	# brew bundle prints one line per entry while it checks the Brewfile, then
	# goes quiet while it downloads and installs everything that was missing.
	# --verbose keeps the download progress visible so it does not look hung,
	# and shows the password prompt for the few casks (zoom) that use a pkg
	# installer and need sudo.
	info "installing missing Brewfile entries, this can take a while"
	brew bundle --file=$DOTFILES_ROOT/Brewfile --no-upgrade --verbose
end

function setup_gitconfig
	set managed (git config --global --get dotfiles.managed)
	# if there is no user.email, we'll assume it's a new machine/setup and ask it
	if test -z (git config --global --get user.email)
		user 'What is your github author name?'
		read user_name
		user 'What is your github author email?'
		read user_email

		test -n $user_name
			or echo "please inform the git author name"
		test -n $user_email
			or abort "please inform the git author email"

		git config --global user.name $user_name
			and git config --global user.email $user_email
			or abort 'failed to setup git user name and email'
	else if test "$managed" != true
		# if user.email exists, let's check for dotfiles.managed config. If it is
		# not true, we'll backup the gitconfig file and set previous user.email and
		# user.name in the new one
		set user_name (git config --global --get user.name)
			and set user_email (git config --global --get user.email)
			and mv ~/.gitconfig ~/.gitconfig.backup
			and git config --global user.name $user_name
			and git config --global user.email $user_email
			and success "moved ~/.gitconfig to ~/.gitconfig.backup"
			or abort 'failed to setup git user name and email'
	else
		# otherwise this gitconfig was already made by the dotfiles
		info "already managed by dotfiles"
	end
	# include the gitconfig.local file
	# finally make git knows this is a managed config already, preventing later
	# overrides by this script
	git config --global include.path ~/.gitconfig.local
		and git config --global dotfiles.managed true
		or abort 'failed to setup git'
end

function link_file -d "links a file keeping a backup"
	echo $argv | read -l old new backup
	if test -e $new
		set newf (readlink $new)
		if test "$newf" = "$old"
			success "skipped $old"
			return
		else
			mv $new $new.$backup
				and success moved $new to $new.$backup
				or abort "failed to backup $new to $new.$backup"
		end
	end
	mkdir -p (dirname $new)
		and ln -sf $old $new
		and success "linked $old to $new"
		or abort "could not link $old to $new"
end

function install_dotfiles
	for src in $DOTFILES_ROOT/*/*.symlink
		link_file $src $HOME/.(basename $src .symlink) backup
			or abort 'failed to link config file'
	end

	for package in $DOTFILES_ROOT/*/
		stow -R -t ~/.config (basename $package) --ignore install\.fish --ignore '.*\.symlink' --ignore '\.DS_Store'
			and success (basename $package)
	end
end

function install_fisher
	# fisher is itself a fish function that only exists once fisher has been
	# installed, so bootstrap it from the network the first time.
	if not functions -q fisher
		info "installing fisher"
		curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
			and fisher install jorgebucaran/fisher
			or abort 'failed to install fisher'
	end
	fisher update
end

install_brewfile
	and success 'brewfile'
	or abort 'brewfile'

setup_gitconfig
	and success 'gitconfig'
	or abort 'gitconfig'

install_dotfiles
	and success 'dotfiles'
	or abort 'dotfiles'

install_fisher
	and success 'plugins'
	or abort 'plugins'

mkdir -p ~/.config/fish/completions/
	and success 'completions'
	or abort 'completions'

for installer in */install.fish
	$installer
		and success $installer
		or abort $installer
end

if ! grep (command -v fish) /etc/shells
	command -v fish | sudo tee -a /etc/shells
		and success 'added fish to /etc/shells'
		or abort 'setup /etc/shells'
	echo
end

test (which fish) = $SHELL
	and success 'dotfiles installed/updated!'
	and exit 0

chsh -s (which fish)
	and success set (fish --version) as the default shell
	or abort 'set fish as default shell'

success 'dotfiles installed/updated!'
