if status is-interactive
    # Commands to run in interactive sessions can go here
    bind -M insert \cf accept-autosuggestion
    fzf_configure_bindings --directory=\cD --git_log=\cL --git_status=\cS

    source ~/.secrets
    set -g hydro_color_git red
    set -g hydro_color_pwd green
    set -g fish_color_selection yellow --bold
    gvm use go1.16.7

    alias vim=nvim

    fish_ssh_agent
end



