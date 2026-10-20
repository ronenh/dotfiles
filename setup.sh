#!/bin/sh
#
# setup.sh: the only thing to run on a brand-new Mac.
#
# bootstrap.fish needs fish, stow and git, and on a fresh machine none of
# those exist until Homebrew does. This script is plain POSIX sh so it can
# run first. It:
#
#   1. installs the Xcode Command Line Tools (git, compilers)
#   2. installs Homebrew
#   3. installs everything in Brewfile
#   4. hands off to bootstrap.fish
#
# It is safe to re-run: every step is skipped when already done.
#
# Usage, from the repo root:
#
#   ./setup.sh
#
# Or, before the repo is cloned:
#
#   curl -fsSL https://raw.githubusercontent.com/ronenh/dotfiles/master/setup.sh | sh
#
# (the curl form clones the repo into ~/ronenh/dotfiles first)

set -eu

DOTFILES_REPO="git@github.com:ronenh/dotfiles.git"
DOTFILES_REPO_HTTPS="https://github.com/ronenh/dotfiles.git"
DOTFILES_DIR="$HOME/ronenh/dotfiles"

info()    { printf '[ .. ] %s\n' "$*"; }
success() { printf '[ OK ] %s\n' "$*"; }
abort()   { printf '[ABRT] %s\n' "$*" >&2; exit 1; }

if [ "$(uname -s)" != "Darwin" ]; then
	abort "setup.sh only supports macOS"
fi

# --- 1. Xcode Command Line Tools -------------------------------------------

if xcode-select -p >/dev/null 2>&1; then
	success "Xcode Command Line Tools already installed"
else
	info "installing Xcode Command Line Tools (a dialog will open)"
	xcode-select --install >/dev/null 2>&1 || true
	# xcode-select returns immediately; wait for the GUI installer to finish.
	until xcode-select -p >/dev/null 2>&1; do
		sleep 5
	done
	success "Xcode Command Line Tools installed"
fi

# --- 2. Homebrew -----------------------------------------------------------

if [ -x /opt/homebrew/bin/brew ]; then
	success "Homebrew already installed"
else
	info "installing Homebrew"
	NONINTERACTIVE=1 /bin/bash -c \
		"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ||
		abort "Homebrew install failed"
	success "Homebrew installed"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# --- 3. Clone the repo if we were piped from curl --------------------------

if [ -f "./bootstrap.fish" ] && [ -f "./Brewfile" ]; then
	DOTFILES_DIR="$(pwd -P)"
elif [ -d "$DOTFILES_DIR" ]; then
	success "dotfiles already cloned at $DOTFILES_DIR"
else
	info "cloning dotfiles into $DOTFILES_DIR"
	mkdir -p "$(dirname "$DOTFILES_DIR")"
	# SSH keys are usually not set up yet on a fresh machine; fall back to
	# https and let `git remote set-url` fix it later.
	git clone "$DOTFILES_REPO" "$DOTFILES_DIR" 2>/dev/null ||
		git clone "$DOTFILES_REPO_HTTPS" "$DOTFILES_DIR" ||
		abort "could not clone dotfiles"
	success "cloned dotfiles"
fi

cd "$DOTFILES_DIR"

# --- 4. Brewfile -----------------------------------------------------------

info "installing Brewfile (this takes a while the first time)"
brew bundle --file="$DOTFILES_DIR/Brewfile" --no-upgrade || abort "brew bundle failed"
success "Brewfile installed"

# --- 5. Hand off to fish ---------------------------------------------------

info "running bootstrap.fish"
exec fish "$DOTFILES_DIR/bootstrap.fish"
