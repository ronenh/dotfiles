# Brewfile: everything Homebrew installs on a new machine.
#
#   brew bundle --file=Brewfile          # install what is missing
#   brew bundle check --file=Brewfile    # report what is missing
#   brew bundle dump --force --file=/tmp/Brewfile && diff /tmp/Brewfile Brewfile
#
# bootstrap.fish runs the first command on every run.
# Keep this file sorted within each section.

# ---------------------------------------------------------------------------
# Taps
# ---------------------------------------------------------------------------
tap "0x1b2c/veil"		# Veil neovim GUI
tap "nikitabobko/tap"	# aerospace

# ---------------------------------------------------------------------------
# Shell and terminal basics (needed by bootstrap.fish itself)
# ---------------------------------------------------------------------------
# User-friendly command-line shell for UNIX-like operating systems
brew "fish"
# Organize software neatly under a single directory tree (e.g. /usr/local)
brew "stow"
# Cross-shell prompt for astronauts
brew "starship"
# Terminal multiplexer
brew "tmux"

# ---------------------------------------------------------------------------
# CLI replacements and helpers
# ---------------------------------------------------------------------------
# Clone of cat(1) with syntax highlighting and Git integration
brew "bat"
# File comparison utilities
brew "diffutils"
# Simple, fast and user-friendly alternative to find
brew "fd"
# Command-line fuzzy finder written in Go
brew "fzf"
# Syntax-highlighting pager for git and diff output
brew "git-delta"
# Colorize logfiles and command output
brew "grc"
# Improved top (interactive process viewer)
brew "htop"
# Lightweight and flexible command-line JSON processor
brew "jq"
# Clone of ls with colorful output, file type icons, and more
brew "lsd"
# Ambitious Vim-fork focused on extensibility and agility
brew "neovim"
# Swiss-army knife of markup format conversion
brew "pandoc"
# Search tool like grep and The Silver Searcher
brew "ripgrep"
# 7-Zip is a file archiver with a high compression ratio
brew "sevenzip"
# Display directories as trees (with optional color/HTML output)
brew "tree"
# Blazing fast terminal file manager written in Rust, based on async I/O
brew "yazi"
# Process YAML, JSON, XML, CSV and properties documents from the CLI
brew "yq"
# Shell extension to navigate your filesystem faster
brew "zoxide"

# ---------------------------------------------------------------------------
# Language runtimes
# One system-wide version of each. Add a version manager (mise, nvm, ...)
# only if a project needs pinned versions.
# ---------------------------------------------------------------------------
# Open source programming language to build simple/reliable/efficient software
brew "go"
# Open-source, cross-platform JavaScript runtime environment
brew "node"
# Fast, disk space efficient package manager
brew "pnpm"
# Development kit for the Java programming language
# brew "openjdk"
# Extremely fast Python package installer and resolver, written in Rust
brew "uv"

# ---------------------------------------------------------------------------
# Dev tooling
# ---------------------------------------------------------------------------
# Official Amazon AWS command-line interface
brew "awscli"
# User-friendly launcher for Bazel
# brew "bazelisk"
# Format bazel BUILD files with a standard convention
# brew "buildifier"
# Validate and define text-based and dynamic configuration
# brew "cue"
# Pack, ship and run any application as a lightweight container
brew "docker"
# Docker Credential Helper for Amazon ECR
brew "docker-credential-helper-ecr"
# GitHub command-line tool
brew "gh"
# Database migrations CLI tool
# brew "golang-migrate"
# Fast linters runner for Go
brew "golangci-lint"
# Tools for building Bazel targets when source files change
# brew "ibazel"
# Graphical front-end for GCC's coverage testing tool (gcov)
# brew "lcov"
# Postgres C API library
# brew "libpq"
# Scalable distributed version control system
# brew "mercurial"
# Generic machine emulator and virtualizer
brew "qemu"
# Editor of encrypted files
# brew "sops"
# Terraform version manager inspired by rbenv
# brew "tfenv"
# Linter for Terraform files
# brew "tflint"
# Vulnerability scanner for container images, file systems, and Git repos
brew "trivy"

# ---------------------------------------------------------------------------
# Kubernetes
# ---------------------------------------------------------------------------
# Kubernetes package manager
brew "helm"
# Kubernetes CLI To Manage Your Clusters In Style!
brew "k9s"
# Colorize your kubectl output
brew "kubecolor"
# Kubernetes command-line interface
brew "kubernetes-cli"
# Tool that can switch between kubectl contexts easily and create aliases
brew "kubectx"
# Application lifecycle orchestration
# brew "akuity/tap/kargo"

# ---------------------------------------------------------------------------
# Networking
# ---------------------------------------------------------------------------
# Easiest, most secure way to use WireGuard and 2FA
# brew "tailscale", restart_service: :changed
# Anonymizing overlay network for TCP
brew "tor", restart_service: :changed

# ---------------------------------------------------------------------------
# Casks: terminals, editors, window management
# ---------------------------------------------------------------------------
# AeroSpace is an i3-like tiling window manager for macOS
cask "nikitabobko/tap/aerospace", trusted: true
# Enable Windows-like alt-tab
cask "alt-tab"
# GPU-based terminal emulator
cask "kitty"
# A Neovim GUI built for efficiency, not for cool
cask "0x1b2c/veil/veil", trusted: true
# Open-source code editor
cask "visual-studio-code"

# ---------------------------------------------------------------------------
# Casks: dev and infra apps
# ---------------------------------------------------------------------------
# Universal database tool and SQL client
# cask "dbeaver-community"
# App to build and share containerised applications and microservices
# cask "docker-desktop"
# App to manage software development and track bugs
# cask "linear"
# Reverse proxy, secure introspectable tunnels to localhost
cask "ngrok"
# Run large language models locally
# cask "ollama-app"
# Mesh VPN based on WireGuard
# cask "tailscale-app"

# ---------------------------------------------------------------------------
# Casks: everyday apps
# ---------------------------------------------------------------------------
# Password manager that keeps all passwords secure behind one password
cask "1password"
# Command-line interface for 1Password
cask "1password-cli"
# Web browser focusing on privacy
cask "brave-browser"
# OpenAI's official ChatGPT desktop app
cask "chatgpt"
# Anthropic's official Claude AI desktop app
cask "claude"
# Bitcoin thin client
cask "electrum"
# Web browser
cask "firefox@developer-edition"
# AI notepad for meetings
cask "granola"
# Knowledge base that works on top of a local folder of plain text Markdown files
cask "obsidian"
# Team communication and collaboration software
# cask "slack"
# Tool to manage Synology NAS's across a LAN
# cask "synologyassistant"
# Web browser focusing on security
cask "tor-browser"
# AI-powered voice dictation
cask "wispr-flow"
# Video communication and virtual meeting platform
cask "zoom"

# ---------------------------------------------------------------------------
# Mac App Store apps. These are owned by the system and cannot be installed
# or adopted as casks. `mas` needs you to be signed in to the App Store.
# Find an id with `mas search <name>`.
# ---------------------------------------------------------------------------
# Mac App Store command-line interface
brew "mas"
mas "WhatsApp", id: 310633997

# ---------------------------------------------------------------------------
# Fonts (kitty and the neovim GUI use Maple Mono NF)
# ---------------------------------------------------------------------------
cask "font-hack-nerd-font"
cask "font-maple-mono-nf"
cask "font-maple-mono-normal-nf"

# ---------------------------------------------------------------------------
# VS Code extensions
# ---------------------------------------------------------------------------
vscode "amazonwebservices.aws-toolkit-vscode"
vscode "antfu.pnpm-catalog-lens"
vscode "anthropic.claude-code"
vscode "bazelbuild.vscode-bazel"
vscode "bradlc.vscode-tailwindcss"
vscode "cedar-policy.vscode-cedar"
vscode "eamodio.gitlens"
vscode "esbenp.prettier-vscode"
vscode "github.vscode-github-actions"
vscode "golang.go"
vscode "marimo-team.vscode-marimo"
vscode "ms-azuretools.vscode-containers"
vscode "ms-python.debugpy"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-python.vscode-python-envs"
vscode "ms-toolsai.jupyter"
vscode "ms-toolsai.jupyter-keymap"
vscode "ms-toolsai.jupyter-renderers"
vscode "ms-toolsai.vscode-jupyter-cell-tags"
vscode "ms-toolsai.vscode-jupyter-slideshow"
vscode "ms-vscode-remote.remote-containers"
vscode "openai.chatgpt"
vscode "openai.codex-audio"
vscode "ryuta46.multi-command"
vscode "svelte.svelte-vscode"
vscode "tamasfe.even-better-toml"
vscode "vitest.explorer"
vscode "vscodevim.vim"

# ---------------------------------------------------------------------------
# uv tools (installed with `uv tool install`)
# ---------------------------------------------------------------------------
uv "batrachian-toad"
uv "harbor"
uv "keyring", with: ["keyrings-codeartifact"]
uv "pre-commit"

# ---------------------------------------------------------------------------
# npm globals
# ---------------------------------------------------------------------------
npm "@agentclientprotocol/claude-agent-acp"
npm "@anthropic-ai/dxt"
npm "mintlify"
npm "skills"
