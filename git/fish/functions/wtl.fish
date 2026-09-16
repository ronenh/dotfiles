function wtl -d "List this repo's worktrees"
    set -l root (__wt_root)
    or begin
        echo "wtl: not inside a git repository" >&2
        return 1
    end
    # Paths all share $root as a prefix; drop it so the list is easier to scan
    git -C $root worktree list | string replace -- "$root/" ""
end
