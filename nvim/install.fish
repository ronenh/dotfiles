#!/usr/bin/env fish

# install vim-plug
curl -fLo ~/.config/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Use nvim as man pager
# set -Ux MANPAGER "/bin/sh -c \"col -bx | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
