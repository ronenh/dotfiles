# Communications layout

Press **Control+Option+S** to open any missing Slack, WhatsApp, Messages, and
Apple Mail apps and arrange workspace S:

```text
┌──────────────┬────────────────────┐
│              │ WhatsApp / Messages│
│    Slack     │     (accordion)    │
│              ├────────────────────┤
│              │        Mail        │
└──────────────┴────────────────────┘
```

The shortcut is in `aerospace/aerospace.toml`. After changing the config, run
`aerospace reload-config`. The script is installed alongside the config by the
existing AeroSpace directory symlink.

Run it directly to see any errors:

```sh
~/.config/aerospace/messaging-layout.sh
~/.config/aerospace/messaging-layout.sh --dry-run
~/.config/aerospace/messaging-layout.sh S
```

The optional final argument changes the destination workspace. The script
rebuilds the layout on every invocation, so launch order and existing nesting
do not matter. It sets equal column widths and equal heights for the two right
panes. Use Option+H/L to switch between WhatsApp and Messages when that accordion
has focus. It does not explicitly switch your current workspace.

Both scripts use `layout-apps.sh` to open apps without a detected window and
wait up to 30 seconds for all required windows. Apps that already have a window
are not relaunched. Opening a running app with no windows requests that macOS
reopen it; if it does not create a window, open its main window manually and retry.
If launch fails or a window never appears, the script stops before arranging
anything; apps already launched remain open. Multiple windows belonging to one
of the required apps or unrelated tiled windows on the destination also stop
the layout. Existing unrelated floating windows are left alone.
`--dry-run` never opens apps or changes windows; if windows are missing, it lists
the apps it would open instead of printing layout commands with unknown IDs.
Exit macOS native fullscreen before running; AeroSpace fullscreen is cleared by
the script. If a window closes while the script is running, reopen it and rerun.

Shortcut output is saved to `${TMPDIR:-/tmp/}aerospace-messaging-layout.log`.
The script runs on demand; no startup or window-detection automation is enabled.

## Calendar and Zoom layout

Press **Control+Option+C** to open any missing Calendar and Zoom Workplace apps
and arrange them in a horizontal accordion on workspace C.
Use Option+H/L to switch between the two windows when that workspace has focus.

```sh
~/.config/aerospace/calendar-zoom-layout.sh
~/.config/aerospace/calendar-zoom-layout.sh --dry-run
```

The config assigns workspace C to the `built-in` display using
`workspace-to-monitor-force-assignment`. This applies whenever that display is
available; it cannot target the built-in display while it is disconnected or
unavailable in clamshell mode. Reload AeroSpace after installing the config.

The script waits up to 30 seconds for one window per app. It stops before layout
changes if either has multiple windows (including additional Zoom meeting
windows) or an unrelated tiled window is on C. Unrelated floating windows are
left alone. Exit macOS native fullscreen first. The script runs on demand and
does not explicitly switch focus to C.

Shortcut output is saved to `${TMPDIR:-/tmp/}aerospace-calendar-zoom-layout.log`.
