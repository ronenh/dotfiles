function __wt_root -d "Print the directory that holds this repo's worktrees"
    set -l common (git rev-parse --git-common-dir 2>/dev/null)
    or return 1
    # In a bare-clone layout this is <root>/.bare; in a normal clone, <root>/.git
    path dirname (path resolve $common)
end
