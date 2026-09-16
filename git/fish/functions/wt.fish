function wt -d "Create or jump to a git worktree for a branch"
    if test (count $argv) -eq 0
        echo "usage: wt <branch> [base-ref]" >&2
        echo "  creates <repo-root>/<branch> from origin's default branch (or [base-ref])" >&2
        return 1
    end

    set -l branch $argv[1]
    set -l root (__wt_root)
    or begin
        echo "wt: not inside a git repository" >&2
        return 1
    end

    # slashes in branch names become dashes in the directory name, so no empty
    # parent dirs are left behind on removal
    set -l dir "$root/"(string replace -a / - $branch)

    if test -d $dir
        cd $dir
        return 0
    end

    git -C $root fetch --quiet origin
    or echo "wt: fetch failed, continuing with local refs" >&2

    if git -C $root show-ref --verify --quiet "refs/heads/$branch"
        git -C $root worktree add $dir $branch
    else if git -C $root show-ref --verify --quiet "refs/remotes/origin/$branch"
        git -C $root worktree add --track -b $branch $dir "origin/$branch"
    else
        set -l base $argv[2]
        test -z "$base"; and set base (__wt_default_base)
        git -C $root worktree add -b $branch $dir $base
    end
    or return 1

    # A bare clone copies refs/heads/* wholesale, so branches that came from the
    # remote exist locally but with no upstream. Set it so push/pull just work.
    if not git -C $dir rev-parse --abbrev-ref '@{upstream}' >/dev/null 2>&1
        if git -C $root show-ref --verify --quiet "refs/remotes/origin/$branch"
            git -C $root branch --quiet --set-upstream-to "origin/$branch" $branch
        end
    end

    __wt_copy_untracked $root $dir
    cd $dir
end
