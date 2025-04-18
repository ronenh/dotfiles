#!/usr/bin/env fish
set DOTFILES_ROOT (pwd -P)

for src in $DOTFILES_ROOT/*/*.symlink
	echo source: $src
	echo trimmed: (string replace $DOTFILES_ROOT/ '' $src)
	echo dirname: (dirname $src)
	echo basename: (basename $src)
	# link_file $src $HOME/.(basename $src .symlink) backup
	#     or abort 'failed to link config file'
end
