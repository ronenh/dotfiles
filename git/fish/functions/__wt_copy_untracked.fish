function __wt_copy_untracked -a root dest -d "Copy files listed in <root>/.worktree-copy into a new worktree"
    set -l manifest "$root/.worktree-copy"
    test -f $manifest; or return 0

    set -l sources (git -C $root worktree list --porcelain | string replace -f -r '^worktree ' '')
    set -l copied

    for line in (cat $manifest)
        set -l rel (string trim $line)
        test -z "$rel"; and continue
        string match -q '#*' $rel; and continue
        test -e "$dest/$rel"; and continue

        for src in $sources
            test "$src" = "$dest"; and continue
            if test -e "$src/$rel"
                mkdir -p (path dirname "$dest/$rel")
                cp -R "$src/$rel" "$dest/$rel"
                set -a copied $rel
                echo "wt: copied $rel"
                break
            end
        end
    end

    test (count $copied) -eq 0; and return 0

    # Mark them ignored for THIS worktree only, so they don't show up as
    # untracked changes and don't block `git worktree remove` later.
    set -l exclude (git -C $dest rev-parse --git-path info/exclude)
    mkdir -p (path dirname $exclude)
    printf '# added by wt\n' >> $exclude
    for rel in $copied
        printf '/%s\n' $rel >> $exclude
    end
end
