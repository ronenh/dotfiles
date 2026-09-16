function wtcd -d "Jump to one of this repo's worktrees (fzf)"
    set -l target
    if test (count $argv) -gt 0
        set -l root (__wt_root); or return 1
        set target "$root/"(string replace -a / - $argv[1])
    else
        set target (__wt_pick "worktree>")
    end
    test -z "$target"; and return 1
    test -d "$target"; or begin
        echo "wtcd: no such worktree: $target" >&2
        return 1
    end
    cd $target
end
