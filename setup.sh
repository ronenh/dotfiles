#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

# Create symbolic links
ln -s $SCRIPT_DIR/ackrc ~/.ackrc
ln -s $SCRIPT_DIR/vimrc ~/.vimrc
ln -s $SCRIPT_DIR/zshrc ~/.zshrc
ln -s $SCRIPT_DIR/gitconfig ~/.gitconfig
