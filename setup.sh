#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)
DOTFILES="ackrc vimrc zshrc gitconfig fzf_funcs.zsh"
HOMEBREW_INSTALLER=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
HOMEBREW_FORMULAE="vim antigen ctags fzf pyenv pyenv-virtualenv autojump"

# Create symbolic links
for dotfile in $DOTFILES; do
    echo "Creating symlink for ~/.$dotfile."
    ln -s $SCRIPT_DIR/$dotfile ~/.$dotfile
done

# Install homebrew
echo "Installing Homebrew from $HOMEBREW_INSTALLER"
/bin/bash -c "$(curl -fsSL $HOMEBREW_INSTALLER)"

# Pour core formulae
brew install $HOMEBREW_FORMULAE

# copy VIM ALE plugin configuration
mkdir ~/.vim/ftplugin
cp $SCRIPT_DIR/ftplugin/* ~/.vim/ftplugin/
