# Avoid the AeroSpace fullscreen shortcut on Ctrl+Alt+F.
if status is-interactive
    # set -g fzf_fd_opts --type d
    fzf_configure_bindings --directory=ctrl-alt-d
end

# curl-installed CLIs (claude, amp, aws, kubectl, ...) land here.
fish_add_path ~/.local/bin

# opencode
fish_add_path ~/.opencode/bin
