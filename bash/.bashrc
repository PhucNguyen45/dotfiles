# =============================================================================
# ~/.bashrc
# =============================================================================

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- History ---
HISTCONTROL=ignoreboth
HISTSIZE=2000
HISTFILESIZE=4000
shopt -s histappend

# --- Prompt ---
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# --- Aliases ---
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# --- Modern CLI (if available) ---
if command -v eza &>/dev/null; then
	alias ls='eza --icons=never --color=always'
	alias ll='eza -la --icons=never --color=always --git'
	alias la='eza -a --icons=never --color=always'
	alias l='eza --icons=never --color=always'
fi

if command -v batcat &>/dev/null; then
	alias cat='batcat --style=plain --paging=never'
elif command -v bat &>/dev/null; then
	alias cat='bat --style=plain --paging=never'
fi

if command -v rg &>/dev/null; then
	alias grep='rg --smart-case'
fi

# --- zoxide ---
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init bash)"
fi

# --- Atuin ---
if command -v atuin &>/dev/null; then
	eval "$(atuin init bash)"
fi

# --- Starship ---
if command -v starship &>/dev/null; then
	eval "$(starship init bash)"
fi

# --- Completions ---
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# --- broot ---
if [ -f "$HOME/.config/broot/launcher/bash/br" ]; then
	source "$HOME/.config/broot/launcher/bash/br"
fi
