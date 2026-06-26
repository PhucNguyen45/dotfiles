# Dotfiles — PhucNguyen45

> Personal dotfiles configuration for WSL2 Ubuntu & macOS.
> Built with modern CLI tools in mind (2025/2026 stack).

## What's Included

| Category | Files | Description |
|----------|-------|-------------|
| Zsh | `zsh/` | Zinit + Powerlevel10k + modular config |
| Bash | `bash/` | Cross-shell config with same modern aliases |
| Git | `git/` | Aliases (lg, st, undo, pf, pl), global gitignore |
| Tmux | `tmux/` | Prefix Ctrl+a, vim navigation, mouse support |
| Vim | `vim/` | Syntax highlighting, relative numbers, leader key |
| Starship | `starship/` | Fallback prompt (p10k primary for zsh) |
| Scripts | `bin/` | CLI utilities (spot, port, mkcd, tree) |

## Quick Start

```bash
# Clone
git clone git@github.com:PhucNguyen45/dotfiles.git ~/.dotfiles

# Full setup (packages + symlinks + shell)
~/.dotfiles/scripts/bootstrap.sh

# Or just symlinks
~/.dotfiles/scripts/symlink.sh install
```

## Structure

```
~/.dotfiles/
├── zsh/
│   ├── .zshrc                 # Main config (Zinit + plugins)
│   └── .zshrc.d/              # Modular config files
│       ├── 00-exports.zsh     # Environment variables
│       ├── 01-aliases.zsh     # Aliases (ls, cat, grep, git...)
│       ├── 02-functions.zsh   # Custom functions (c, mkcd, spot...)
│       ├── 03-fzf.zsh        # fzf configuration
│       ├── 04-ssh.zsh         # SSH agent
│       ├── 05-misc.zsh        # Misc (broot, man pages...)
│       ├── 06-ai-agents.zsh   # AI coding agent aliases
│       └── 07-workspace.zsh   # mise auto-switch wrappers
├── bash/
│   └── .bashrc
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── tmux/
│   └── .tmux.conf
├── vim/
│   └── .vimrc
├── starship/
│   └── starship.toml
├── bin/                       # CLI scripts
├── scripts/
│   ├── bootstrap.sh           # Full machine setup
│   └── symlink.sh             # Symlink manager
├── README.md
└── .gitignore
```

## Key Features

### Modern CLI Stack (2025/2026)
- **eza** — Modern ls with git status
- **bat/batcat** — Cat with syntax highlighting
- **ripgrep** — Blazingly fast grep
- **fd/fdfind** — Fast file search
- **zoxide** — Smart directory jumper
- **fzf** — Fuzzy finder with preview
- **atuin** — Syncable shell history
- **starship** — Cross-shell prompt (fallback)

### Git Aliases
- `git lg` — Pretty log graph
- `git st` — Status shorthand
- `git undo` — Undo last commit
- `git pf` — Force push with lease
- `git pl` — Pull with rebase

### Tmux
- Prefix: Ctrl+a | Split: | (v) / - (h)
- Vim navigation: Ctrl+h/j/k/l

## Security

- No secrets committed. API keys and tokens stay local.
- SSH keys managed via ssh-agent (in `04-ssh.zsh`).

## Inspired By

- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
- [Holman's dotfiles](https://github.com/holman/dotfiles)
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
