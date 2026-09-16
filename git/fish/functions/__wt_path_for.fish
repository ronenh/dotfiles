function __wt_path_for -a name -d "Resolve a branch name or directory name to a worktree path"
    set -l root (__wt_root); or return 1

    # 1. exact branch match, read from git rather than guessed from the name —
    #    worktrees created outside `wt` need not live at <root>/<branch-with-dashes>
    set -l path ""
    for line in (git -C $root worktree list --porcelain)
        if string match -q 'worktree *' $line
            set path (string replace 'worktree ' '' $line)
        else if string match -q 'branch *' $line
            if test (string replace 'branch refs/heads/' '' $line) = "$name"
                echo $path
                return 0
            end
        end
    end

    # 2. the name `wt` would have generated
    set -l guess "$root/"(string replace -a / - $name)
    if test -d $guess
        echo $guess
        return 0
    end

    # 3. directory basename
    for w in (git -C $root worktree list --porcelain | string replace -f -r '^worktree ' '')
        if test (path basename $w) = "$name"
            echo $w
            return 0
        end
    end

    return 1
end
