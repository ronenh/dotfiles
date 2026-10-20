function wtclone -d "Clone a repo into a bare-clone + sibling-worktrees layout"
    # wtclone <repo-url> [root-dir]
    #
    # Produces:
    #   <root>/.bare/          the git directory
    #   <root>/.git            file: "gitdir: ./.bare"  (lets git commands run from <root>)
    #   <root>/<default>/      a worktree for the default branch — not privileged
    #   <root>/.worktree-copy  list of untracked files to seed into new worktrees
    #
    # <root-dir> defaults to the repo name, under the current directory
    # (the same place `git clone` would put it).
    if test (count $argv) -eq 0 -o (count $argv) -gt 2
        echo "usage: wtclone <repo-url> [root-dir]" >&2
        return 1
    end

    set -l url $argv[1]
    set -l root $argv[2]
    if test -z "$root"
        # git@host:owner/name.git, https://host/owner/name, /local/path/name/ → name
        set root (string replace -r '/+$' '' $url | path basename | string replace -r '\.git$' '')
    end
    set root (path resolve $root)

    if test -e $root; and test (count (command ls -A $root)) -gt 0
        echo "wtclone: $root already exists and is not empty" >&2
        return 1
    end

    echo "==> cloning $url (bare) into $root/.bare"
    mkdir -p $root; or return 1
    git clone --bare $url $root/.bare; or return 1

    echo "==> writing $root/.git"
    echo 'gitdir: ./.bare' >$root/.git

    # A bare clone does not populate refs/remotes/origin/*, which silently breaks
    # branch tracking and leaves every new worktree branching off a stale base.
    echo "==> fixing fetch refspec"
    git -C $root config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'; or return 1
    git -C $root fetch origin; or return 1

    echo "==> resolving default branch"
    git -C $root remote set-head origin --auto >/dev/null; or return 1
    set -l default (git -C $root symbolic-ref --short refs/remotes/origin/HEAD | string replace -r '^origin/' '')
    if test -z "$default"
        echo "wtclone: could not determine the remote's default branch" >&2
        return 1
    end
    echo "    default branch: $default"

    echo "==> adding worktree $root/$default"
    git -C $root worktree add $root/$default $default; or return 1

    # A bare clone copies refs/heads/* wholesale, so the default branch already
    # existed locally and `worktree add` just checked it out — with no upstream.
    # Without this, `git pull` / `git push` in that worktree need explicit
    # arguments and `git status -sb` shows "## main" instead of
    # "## main...origin/main". Same hazard `wt` handles for the branches it creates.
    git -C $root branch --quiet --set-upstream-to origin/$default $default; or return 1

    if not test -f $root/.worktree-copy
        echo "==> seeding $root/.worktree-copy"
        printf '%s\n' \
            '# Untracked files to copy into each new worktree created by `wt`.' \
            '# One repo-relative path per line. Lines starting with # are ignored.' \
            '# Existing files in the destination are never overwritten.' \
            '#' \
            '# local.env' \
            '# .envrc' >$root/.worktree-copy
    end

    echo
    echo "Done."
    echo
    echo "  cd $root/$default"
    echo "  wt my-feature      # new worktree at $root/my-feature, branched from origin/$default"
    echo "  wtl                # list"
    echo "  wtcd               # jump (fzf)"
    echo "  wtrm my-feature    # remove worktree + branch"
    echo "  wtclean -n         # preview cleanup of merged worktrees"
    echo
    echo "Next: add any untracked files you need (e.g. local.env) to"
    echo "$root/.worktree-copy so new worktrees get them automatically."
end
