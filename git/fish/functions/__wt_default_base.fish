function __wt_default_base -d "Print the remote's default branch ref (e.g. origin/main)"
    set -l head (git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)
    if test -n "$head"
        echo $head
        return 0
    end
    for b in main master
        if git show-ref --verify --quiet "refs/remotes/origin/$b"
            echo "origin/$b"
            return 0
        end
    end
    echo origin/main
end
