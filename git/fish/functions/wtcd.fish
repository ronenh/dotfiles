function wtcd -d "Jump to one of this repo's worktrees (fzf)"
    set -l target
    if test (count $argv) -gt 0
        set target (__wt_path_for $argv[1])
        or begin
            echo "wtcd: no worktree matching '$argv[1]'" >&2
            return 1
        end
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
