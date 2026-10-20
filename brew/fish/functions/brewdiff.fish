function brewdiff -d "Compare what Homebrew has installed with the repo Brewfile"
    set -l tmp (mktemp -t Brewfile.XXXXXX)
    brew bundle dump --force --file=$tmp >/dev/null 2>&1
    or begin
        rm -f $tmp
        echo "brewdiff: brew bundle dump failed" >&2
        return 1
    end

    # Compare only the type and name, so options like restart_service do
    # not show up as differences. Commented-out Brewfile lines do not match,
    # so they count as "not in the Brewfile".
    set -l pattern '^(?:tap|brew|cask|mas|vscode|uv|npm) "[^"]+"'
    set -l wanted (string match -r $pattern <$DOTFILES/Brewfile | sort)
    set -l installed (string match -r $pattern <$tmp | sort)
    rm -f $tmp

    set -l extra (comm -13 (printf '%s\n' $wanted | psub) (printf '%s\n' $installed | psub))
    set -l missing (comm -23 (printf '%s\n' $wanted | psub) (printf '%s\n' $installed | psub))

    if test (count $extra) -gt 0
        set_color --bold
        echo "Installed here but not in the Brewfile ("(count $extra)"):"
        set_color normal
        echo "  (add to the Brewfile, or leave out of the next machine)"
        printf '  %s\n' $extra
    end
    if test (count $missing) -gt 0
        test (count $extra) -gt 0; and echo
        set_color --bold
        echo "In the Brewfile but not installed here ("(count $missing)"):"
        set_color normal
        echo "  (./bootstrap.fish will install these)"
        printf '  %s\n' $missing
    end
    if test (count $extra) -eq 0 -a (count $missing) -eq 0
        echo "Brewfile and this machine match."
    end
end
