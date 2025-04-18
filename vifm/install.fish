#!/usr/bin/env fish
if command -qs vifm
    mkdir -p $HOME/.config/vifm/colors
    curl -sL https://raw.githubusercontent.com/vifm/vifm-colors/master/dracula.vifm -o $HOME/.config/vifm/colors/dracula.vifm
end
