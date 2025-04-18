# Fish shell and neovim config

## Installation

### Dependencies

First, make sure you have all those things installed:

- `git`: to clone the repo
- `curl`: to download some stuff
- `fish`: the shell
- `stow`: to manage symlinks

### Install/Update

```fish
./bootstrap.fish
```

> All changed files will be backed up with a `.backup` suffix.

## Additional software


- [`kitty`](https://sw.kovidgoyal.net/kitty/) fast configurable shell.
- [`bat`](https://github.com/sharkdp/bat) a `cat` with wings;
- [`delta`](https://github.com/dandavison/delta) for better git diffs;
- [`dog`](https://dns.lookup.dog) the command-line DNS client;
- [`lsd`](https://github.com/lsd-rs/lsd) a modern replacement for `ls`;
- [`fd`](https://github.com/sharkdp/fd) a simple, fast and user-friendly alternative to `find`;
- [`fzf`](https://github.com/junegunn/fzf) for a fuzzy-finder, used in `,t` on vim, for example;
- [`gh`](https://github.com/cli/cli) for more GitHub integration with the terminal;
- [`grc`](https://github.com/garabik/grc) to colorize command's outputs;
- [`starship.rs`](https://starship.rs) the shell we are using;
- [`kubectx`](https://github.com/ahmetb/kubectx) for better Kubernetes context and namespace switch;
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) a faster `grep`;
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) a smarter `cd` command;

To install them all with `brew`:

```fish
brew install fish stow kitty bat git-delta dog lsd fd fzf gh grc kubectx ripgrep starship zoxide
```
