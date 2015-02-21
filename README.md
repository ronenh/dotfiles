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

### Dependencies

Some of the vim plugins depend on external packages that need to be installed.

        apt-get install ack-grep python-rope pylint

To use the :Ack command it is also necessary to create a symlink called `ack` that points at `ack-grep`:

        sudo ln -s /usr/bin/ack-grep /usr/bin/ack



