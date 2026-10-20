#!/usr/bin/env fish
set -Ux EDITOR nvim
set -Ux VISUAL $EDITOR
set -Ux WEDITOR code

# bootstrap.fish runs every install.fish from the repo root.
set -Ux DOTFILES (pwd -P)
set -Ux PROJECTS ~/

# Drop PATH entries left behind by tools that are no longer installed
# (pyenv, opencode, ~/.dotfiles/bin, ...).
set -l kept
for p in $fish_user_paths
    test -d $p; and set -a kept $p
end
set -U fish_user_paths $kept

if test -f ~/.localrc.fish
    ln -sf ~/.localrc.fish ~/.config/fish/conf.d/localrc.fish
end
