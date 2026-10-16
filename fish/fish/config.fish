source ~/.secrets

# Avoid the AeroSpace fullscreen shortcut on Ctrl+Alt+F.
if status is-interactive
    set -g fzf_fd_opts --type d
    fzf_configure_bindings --directory=ctrl-alt-d
end

# opencode
fish_add_path /Users/ronenhilewicz/.opencode/bin

# amp
fish_add_path ~/.local/bin

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
~/.local/bin/mise activate fish | source
