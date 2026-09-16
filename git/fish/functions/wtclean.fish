function wtclean -d "Remove worktrees whose branch is already merged into the default branch"
    argparse n/dry-run -- $argv; or return 1

    set -l root (__wt_root)
    or begin
        echo "wtclean: not inside a git repository" >&2
        return 1
    end

    set -l base (__wt_default_base)
    git -C $root fetch --quiet origin

    set -l merged (git -C $root branch --merged $base --format '%(refname:short)')
    set -l removed 0

    for w in (git -C $root worktree list --porcelain | string replace -f -r '^worktree ' '')
        test "$w" = "$root"; and continue
        string match -q "*/.claude/worktrees/*" $w; and continue

        set -l branch (git -C $w rev-parse --abbrev-ref HEAD 2>/dev/null)
        test -z "$branch"; and continue
        contains -- $branch $merged; or continue
        test "origin/$branch" = "$base"; and continue

        # skip anything with uncommitted work
        set -l dirty (git -C $w status --porcelain)
        if test (count $dirty) -gt 0
            echo "wtclean: skipping $branch (uncommitted changes)"
            continue
        end

        if set -q _flag_dry_run
            echo "would remove: $w ($branch)"
        else
            echo "removing: $w ($branch)"
            git -C $root worktree remove $w; and git -C $root branch -d $branch
            set removed (math $removed + 1)
        end
    end

    set -q _flag_dry_run; or git -C $root worktree prune
    set -q _flag_dry_run; or echo "wtclean: removed $removed worktree(s)"
end
