# Shared by the layout scripts; source this file rather than executing it.
refresh_windows() {
    windows=$(aerospace list-windows --all --format '%{window-id}|%{app-bundle-id}|%{workspace}|%{window-layout}')
}

# Print the unique ID, or an empty string if the app has no detected window.
find_window() {
    local app=$1 label=$2 id bundle workspace layout found=''
    while IFS='|' read -r id bundle workspace layout; do
        [[ "$bundle" == "$app" ]] || continue
        [[ -z "$found" ]] || die "Multiple $label windows are open. Keep only the window to arrange, then retry."
        [[ "$id" =~ ^[0-9]+$ ]] || die "Invalid window ID for $label."
        found=$id
    done <<< "$windows"
    printf '%s\n' "$found"
}

# Arguments are bundle-ID / display-name pairs. Launch all missing apps first,
# then wait for AeroSpace to detect their windows before any layout commands.
prepare_apps() {
    local apps=("$@") missing=() index id deadline pending
    refresh_windows
    for ((index=0; index<${#apps[@]}; index+=2)); do
        id=$(find_window "${apps[index]}" "${apps[index+1]}") || return 1
        if [[ -z "$id" ]]; then
            missing+=("${apps[index]}" "${apps[index+1]}")
        fi
    done
    if ((${#missing[@]} == 0)); then
        return 0
    fi
    for ((index=0; index<${#missing[@]}; index+=2)); do
        if $dry_run; then
            printf 'Would open %s: open -g -b %s\n' "${missing[index+1]}" "${missing[index]}"
        else
            printf 'Opening %s...\n' "${missing[index+1]}" >&2
            open -g -b "${missing[index]}" || die "Could not open ${missing[index+1]}. Check that it is installed."
        fi
    done
    if $dry_run; then
        printf 'Preview only; no apps opened or windows changed. Rerun after windows exist to preview layout commands.\n'
        exit 0
    fi
    deadline=$((SECONDS + 30))
    while :; do
        refresh_windows
        pending=''
        for ((index=0; index<${#apps[@]}; index+=2)); do
            id=$(find_window "${apps[index]}" "${apps[index+1]}") || return 1
            [[ -n "$id" ]] || pending="${pending}${pending:+, }${apps[index+1]}"
        done
        [[ -n "$pending" ]] || return 0
        ((SECONDS < deadline)) || die "Timed out waiting for windows: $pending. Open their main windows and retry. No layout changes were made."
        sleep 0.5
    done
}
