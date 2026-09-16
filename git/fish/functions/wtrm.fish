function wtrm -d "Remove a worktree and delete its branch"
    argparse f/force -- $argv; or return 1

    set -l root (__wt_root)
    or begin
        echo "wtrm: not inside a git repository" >&2
        return 1
    end

    set -l dir
    if test (count $argv) -gt 0
        set dir (__wt_path_for $argv[1])
        or begin
            echo "wtrm: no worktree matching '$argv[1]'" >&2
            return 1
        end
    else
        set dir (__wt_pick "remove worktree>")
    end
    test -z "$dir"; and return 1

    set -l branch (git -C $dir rev-parse --abbrev-ref HEAD 2>/dev/null)

    # don't saw off the branch we're sitting on
    if string match -q "$dir*" (pwd)
        cd $root
    end

    if set -q _flag_force
        git -C $root worktree remove --force $dir; or return 1
        test -n "$branch"; and git -C $root branch -D $branch
    else
        git -C $root worktree remove $dir
        or begin
            echo "wtrm: worktree has changes — commit them, or re-run with -f" >&2
            return 1
        end
        if test -n "$branch"
            git -C $root branch -d $branch 2>/dev/null
            or echo "wtrm: branch '$branch' not merged — worktree gone, branch kept (git -C $root branch -D $branch)" >&2
        end
    end

    git -C $root worktree prune
end
