#!/usr/bin/env fish
if command -q pyenv
    status is-login; and pyenv init --path | source
    # status is-interactive; and pyenv init - | source
end
