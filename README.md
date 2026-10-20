# dotfiles

Fish shell, neovim, kitty and friends, managed with [stow](https://www.gnu.org/software/stow/).

## New machine

Sign in to iCloud and the App Store first: `mas` installs App Store apps
(WhatsApp) and needs the sign-in. Then one command on a fresh Mac:

```sh
curl -fsSL https://raw.githubusercontent.com/ronenh/dotfiles/master/setup.sh | sh
```

Or, if the repo is already cloned, from its root:

```sh
./setup.sh
```

`setup.sh` installs the Xcode Command Line Tools, Homebrew and everything in
[`Brewfile`](Brewfile), then runs `bootstrap.fish`.

### Things `setup.sh` cannot do

Do these by hand after it finishes:

1. Sign in to 1Password.
2. Create an SSH key for this machine with `ssh-keygen -t ed25519`, add it to
   GitHub (`pubkey` copies it), then
   `git remote set-url origin git@github.com:ronenh/dotfiles.git`.
   Keys are per machine and are never copied between them. Secrets come
   from 1Password (`op`) or the keychain (`security`), not from files.
3. Install the CLIs that do not come from Homebrew. They all install into `~/.local/bin`:
   `claude`, `amp`, `webi`.
4. Sign in to the apps (Slack, Linear, Granola, Tailscale, Docker, ...).

## Update

After pulling changes, or editing `Brewfile`, run:

```fish
./bootstrap.fish
```

It is idempotent. Changed files are backed up with a `.backup` suffix.

## Layout

Each top-level directory is a stow package, stowed into `~/.config`:

- `<pkg>/<pkg>/...` lands in `~/.config/<pkg>/...`
- `<pkg>/fish/conf.d/*.fish` and `<pkg>/fish/functions/*.fish` land in the fish config
- `<pkg>/*.symlink` is linked to `~/.<name>` instead
- `<pkg>/install.fish` runs on every bootstrap

Package managers:

- `Brewfile`: Homebrew formulae, casks, fonts, VS Code extensions, uv tools and npm globals.
  `brewdiff` shows what is installed on this machine but missing from it, and the reverse.
- `uv` (from Homebrew): Python interpreters, tools and project environments.
- `fisher/fish/fish_plugins`: fish plugins.
