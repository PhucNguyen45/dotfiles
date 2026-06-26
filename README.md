# 🚀 Dotfiles — PhucNguyen45

> My personal dotfiles configuration for WSL2 Ubuntu & macOS.

## 📦 What's Included

| Category | Files | Description |
|----------|-------|-------------|
| **Shell** | `zsh/.zshrc`, `zsh/.zprofile`, `bash/.bashrc` | Zsh with Zinit + Powerlevel10k, Bash config |
| **Git** | `git/.gitconfig`, `git/.gitignore_global` | Git config with useful aliases & global ignore |
| **Tmux** | `tmux/.tmux.conf` | Terminal multiplexer with vim-like navigation |
| **Vim** | `vim/.vimrc` | Editor config with syntax highlighting & more |
| **Scripts** | `bin/*` | CLI utilities (spot, port, mkcd, tree, etc.) |

## 🛠️ Quick Start

### On a new machine

```bash
# Clone the repo
git clone git@github.com:PhucNguyen45/dotfiles.git ~/.dotfiles

# Run bootstrap (installs packages + symlinks)
~/.dotfiles/scripts/bootstrap.sh
```

### Or install manually

```bash
# Just create symlinks
~/.dotfiles/scripts/symlink.sh install

# Check symlink status
~/.dotfiles/scripts/symlink.sh status

# Remove symlinks
~/.dotfiles/scripts/symlink.sh remove
```

## 🏗️ Repo Structure

```
~/.dotfiles/
├── zsh/           # Zsh configuration
│   ├── .zshrc     # Main Zsh config (Zinit, plugins, aliases)
│   └── .zprofile  # Profile settings
├── bash/          # Bash configuration
│   └── .bashrc    # Bash config
├── git/           # Git configuration
│   ├── .gitconfig # Git user & settings
│   └── .gitignore_global  # Global gitignore
├── tmux/          # Tmux configuration
│   └── .tmux.conf # Tmux config (prefix: Ctrl+a)
├── vim/           # Vim configuration
│   └── .vimrc     # Vim config
├── bin/           # Custom CLI scripts (added to PATH)
│   ├── spot       # File search with preview
│   ├── port       # Port usage viewer
│   ├── mkcd       # Create & cd into directory
│   ├── tree       # Directory tree viewer
│   └── git-clean-branches  # Clean merged branches
└── scripts/       # Utility scripts
    ├── bootstrap.sh   # Full machine setup
    └── symlink.sh     # Symlink manager
```

## 🔧 Custom CLI Scripts

- **`spot`** — Search files with fzf preview (`spot *.md`)
- **`port`** — Check what's running on a port (`port 3000`)
- **`mkcd`** — Create dir & cd into it (`mkcd new-project`)
- **`tree`** — Directory tree visualization (`tree src/`)
- **`git-clean-branches`** — Delete merged local branches

## 📝 Key Config Highlights

### Git Aliases
- `git lg` — Pretty log graph
- `git st` — Status shorthand
- `git undo` — Undo last commit
- `git amend` — Amend last commit (no edit)
- `git pf` — Force push with lease
- `git pl` — Pull with rebase

### Tmux
- Prefix: `Ctrl+a` (more ergonomic than `Ctrl+b`)
- Split: `|` (vertical), `-` (horizontal)
- Vim navigation: `Ctrl+h/j/k/l`
- Reload config: `Prefix + r`

### Vim
- Leader key: `Space`
- Relative line numbers
- Ctrl+h/j/k/l for split navigation
- `<Leader>w` to save, `<Leader>q` to quit

## 🔒 Security

- **No secrets committed.** API keys, tokens, and passwords stay in local env files.
- SSH keys managed separately via `ssh-agent`.

## 📚 Inspired By

- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
- [Holman's dotfiles](https://github.com/holman/dotfiles)
- [dotfiles.github.io](https://dotfiles.github.io/)

---

*Made with ❤️ by PhucNguyen45*
