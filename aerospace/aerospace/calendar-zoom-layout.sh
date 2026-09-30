#!/bin/bash
# Calendar and Zoom Workplace in a horizontal accordion on workspace C.
set -euo pipefail
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
# Do not inherit the target of an AeroSpace callback.
unset AEROSPACE_WINDOW_ID AEROSPACE_WORKSPACE

usage() {
    cat <<'EOF'
Usage: calendar-zoom-layout.sh [--dry-run]

Opens missing Calendar and Zoom Workplace apps and waits up to 30 seconds
for their windows. Arranges them on workspace C in a horizontal accordion. The AeroSpace config pins C to the
built-in display. Exit macOS native fullscreen before running.

--dry-run         Preview only; do not launch apps or change windows.
EOF
}

die() { printf '%s\n' "$*" >&2; exit 1; }
dry_run=false
destination=C
for argument in "$@"; do
    case "$argument" in
        --dry-run) dry_run=true ;;
        -h|--help) usage; exit 0 ;;
        *) die "Unknown argument: $argument" ;;
    esac
done
command -v aerospace >/dev/null || die 'AeroSpace CLI is not on PATH.'

# Keep launch/wait behavior identical in both layouts.
source "$(dirname "${BASH_SOURCE[0]}")/layout-apps.sh"
prepare_apps com.apple.iCal Calendar us.zoom.xos 'Zoom Workplace'

calendar=$(find_window com.apple.iCal Calendar)
zoom=$(find_window us.zoom.xos 'Zoom Workplace')

# Check the entire destination before issuing any layout commands.
while IFS='|' read -r id bundle workspace layout; do
    [[ "$workspace" == "$destination" ]] || continue
    [[ "$id" != "$calendar" && "$id" != "$zoom" ]] || continue
    [[ "$layout" != floating ]] || continue
    die "Workspace $destination also contains a tiled window from $bundle (ID $id). Move or float it first."
done <<< "$windows"

run() {
    if $dry_run; then
        printf 'aerospace'
        printf ' %q' "$@"
        printf '\n'
    else
        aerospace "$@"
    fi
}

for id in "$calendar" "$zoom"; do
    run fullscreen --window-id "$id" off
    run layout --window-id "$id" tiling
    run move-node-to-workspace --window-id "$id" -- "$destination"
done

# Rebuild a single container, independent of existing nesting or launch order.
run flatten-workspace-tree --workspace "$destination"
run layout --workspace "$destination" --root h_accordion
run move --window-id "$calendar" --boundaries workspace --boundaries-action stop left
run balance-sizes --workspace "$destination"
if $dry_run; then
    printf 'Preview only; no windows changed.\n'
else
    printf 'Layout C: Calendar and Zoom Workplace in a horizontal accordion.\n'
fi
