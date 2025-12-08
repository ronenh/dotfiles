#!/usr/bin/env fish
set -U fish_greeting

function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert \cf accept-autosuggestion
end

funcsave fish_user_key_bindings
