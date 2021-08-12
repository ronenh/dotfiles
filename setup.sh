#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

# Create symbolic links
ln -s $SCRIPT_DIR/ackrc ~/.ackrc
ln -s $SCRIPT_DIR/vimrc ~/.vimrc
ln -s $SCRIPT_DIR/zshrc ~/.zshrc
ln -s $SCRIPT_DIR/gitconfig ~/.gitconfig
ln -s $SCRIPT_DIR/fzf_funcs.zsh ~/.fzf_funcs.zsh

# copy VIM ALE plugin configuration
mkdir ~/.vim/ftplugin
cp $SCRIPT_DIR/ftplugin/* ~/.vim/ftplugin/
