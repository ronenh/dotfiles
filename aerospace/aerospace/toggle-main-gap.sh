#!/bin/bash
# Toggle the main monitor's outer right gap between wide and narrow, then reload.
set -euo pipefail
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

wide=365
narrow=5

usage() {
    cat <<'USAGE'
Usage: toggle-main-gap.sh [--dry-run]

Flips the `monitor.main` entry of gaps.outer.right in aerospace.toml between
365 and 5, then runs `aerospace reload-config`. Any other current value is
treated as wide and switched to 5.

--dry-run         Print the change; do not edit the file or reload.
USAGE
}

die() { printf '%s\n' "$*" >&2; exit 1; }
dry_run=false
for argument in "$@"; do
    case "$argument" in
        --dry-run) dry_run=true ;;
        -h|--help) usage; exit 0 ;;
        *) die "Unknown option: $argument" ;;
    esac
done

config=$(aerospace config --config-path 2>/dev/null || true)
[[ -n "$config" ]] || config="$HOME/.config/aerospace/aerospace.toml"
[[ -f "$config" ]] || die "Config not found: $config"

pattern='^([[:space:]]*\{[[:space:]]*monitor\.main[[:space:]]*=[[:space:]]*)([0-9]+)([[:space:]]*\}.*)$'
current=$(sed -nE "s/$pattern/\2/p" "$config")
[[ -n "$current" ]] || die "No 'monitor.main = <n>' gap entry in $config"
[[ $(printf '%s\n' "$current" | wc -l) -eq 1 ]] || die "More than one 'monitor.main' gap entry in $config"

if [[ "$current" == "$narrow" ]]; then
    next=$wide
else
    next=$narrow
fi
printf 'gaps.outer.right monitor.main: %s -> %s\n' "$current" "$next"
$dry_run && exit 0

sed -i '' -E "s/$pattern/\1$next\3/" "$config"
aerospace reload-config
