# Development Environment Settings

This repo includes VIM and z-shell configuration as well as settings for other tools like ack-grep and tmux.

## Installation

1. Clone the repo to a local directory (`~/.dev` in these instructions).
2. Pull submodules:

        $ cd ~/.dev
        $ git submodule init
        $ git submodule update

3. Run `~/.dev/setup.sh` to create symbolic links in your home directory

## Vim Plugins

Vim plugins are managed using [Vundle.vim](https://github.com/gmarik/Vundle.vim).
Plugins are listed in the Vim configuration file `vimrc`.
To install plugins in a new environment open Vim and run `:PluginInstall`



