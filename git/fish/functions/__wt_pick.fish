function __wt_pick -a prompt -d "Pick a worktree with fzf; prints its path"
    set -l root (__wt_root); or return 1
    set -l wts (git -C $root worktree list --porcelain | string replace -f -r '^worktree ' '')
    set -l choices
    for w in $wts
        # skip the bare root itself and Claude Code's session worktrees
        string match -q "*/.claude/worktrees/*" $w; and continue
        set -a choices $w
    end
    test (count $choices) -eq 0; and return 1
    printf '%s\n' $choices | fzf --reverse --height 40% --prompt "$prompt "
end
