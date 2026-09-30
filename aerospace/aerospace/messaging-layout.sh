#!/bin/bash
# Slack left; WhatsApp/Messages accordion above Mail on the right.
set -euo pipefail
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
# Do not inherit the target of an AeroSpace callback.
unset AEROSPACE_WINDOW_ID AEROSPACE_WORKSPACE

usage() {
    cat <<'EOF'
Usage: messaging-layout.sh [--dry-run] [WORKSPACE]

Defaults to workspace S. Opens missing Slack, WhatsApp, Messages, and Mail
apps and waits up to 30 seconds for their windows. Rebuilds equal-width columns: Slack on the left,
WhatsApp/Messages in an accordion upper right, Mail lower right. Existing
floating windows are left alone. Other tiled windows on the destination
cause an error before layout changes. Exit macOS native fullscreen first.

--dry-run         Preview only; do not launch apps or change windows.
EOF
}

die() { printf '%s\n' "$*" >&2; exit 1; }
dry_run=false
destination=S
destination_set=false
for argument in "$@"; do
    case "$argument" in
        --dry-run) dry_run=true ;;
        -h|--help) usage; exit 0 ;;
        -*) die "Unknown option: $argument" ;;
        *)
            $destination_set && die 'Specify only one workspace.'
            [[ -n "$argument" && "$argument" != *'|'* && "$argument" != *$'\n'* ]] || die 'Invalid workspace name.'
            destination=$argument
            destination_set=true
            ;;
    esac
done
command -v aerospace >/dev/null || die 'AeroSpace CLI is not on PATH.'

# Keep launch/wait behavior identical in both layouts.
source "$(dirname "${BASH_SOURCE[0]}")/layout-apps.sh"
prepare_apps com.tinyspeck.slackmacgap Slack net.whatsapp.WhatsApp WhatsApp com.apple.mail Mail com.apple.MobileSMS Messages

slack=$(find_window com.tinyspeck.slackmacgap Slack)
whatsapp=$(find_window net.whatsapp.WhatsApp WhatsApp)
mail=$(find_window com.apple.mail Mail)
messages=$(find_window com.apple.MobileSMS Messages)

# Check the entire destination before issuing any layout commands.
while IFS='|' read -r id bundle workspace layout; do
    [[ "$workspace" == "$destination" ]] || continue
    [[ "$id" != "$slack" && "$id" != "$whatsapp" && "$id" != "$mail" && "$id" != "$messages" ]] || continue
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

for id in "$slack" "$whatsapp" "$messages" "$mail"; do
    run fullscreen --window-id "$id" off
    run layout --window-id "$id" tiling
    run move-node-to-workspace --window-id "$id" -- "$destination"
done

# Reset previous nesting so rerunning produces the same tree.
run flatten-workspace-tree --workspace "$destination"
run layout --workspace "$destination" --root h_tiles

# Three moves reach the left edge from any position among four windows.
# Bring each window to the front in reverse order: Slack | WA | Messages | Mail.
for id in "$messages" "$whatsapp" "$slack"; do
    run move --window-id "$id" --boundaries workspace --boundaries-action stop left
    run move --window-id "$id" --boundaries workspace --boundaries-action stop left
    run move --window-id "$id" --boundaries workspace --boundaries-action stop left
done
run join-with --window-id "$whatsapp" right
# Mail joins the entire WA/Messages container to its left. Normalization
# gives the inner container horizontal orientation under the vertical right pane.
run join-with --window-id "$mail" left
run layout --window-id "$mail" v_tiles
run layout --window-id "$whatsapp" h_accordion
run balance-sizes --workspace "$destination"
if $dry_run; then
    printf 'Preview only; no windows changed.\n'
else
    printf 'Layout %s: Slack left; WhatsApp/Messages accordion upper right; Mail lower right.\n' "$destination"
fi
