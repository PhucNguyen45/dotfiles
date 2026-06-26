# =============================================================================
# Aliases
# =============================================================================

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias clr='clear'

# Modern CLI replacements
alias ls='eza --icons=never --color=always'
alias ll='eza -la --icons=never --color=always --git'
alias la='eza -a --icons=never --color=always'
alias l='eza --icons=never --color=always'
alias tree='eza --tree --all --icons=never --color=always'
alias cat='batcat --style=plain --paging=never 2>/dev/null || bat --style=plain --paging=never 2>/dev/null || cat'
alias grep='rg 2>/dev/null || grep --color=auto'
alias find='fdfind 2>/dev/null || fd 2>/dev/null || find'
alias y='yazi'

# Safer commands
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# Git shortcuts
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull --rebase'
alias gst='git status'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gclean='git-clean-branches'

# Tmux
alias tm='tmux new-session -A -s main'

# System
alias ip='ip -c'
alias ports='port'
alias df='df -h'
alias du='du -h'
alias free='free -h'
