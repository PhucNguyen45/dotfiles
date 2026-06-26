# ===================================================
#  .zshrc - WSL Ubuntu 26.04
#  Zinit + Powerlevel10k + mise + Modern CLI
# ===================================================

# ----- 0. Powerlevel10k Instant Prompt -----
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ====== 1. Cơ bản & PATH ======
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

setopt EXTENDED_HISTORY APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_IGNORE_ALL_DUPS

export NO_AT_BRIDGE=1
export XDG_SESSION_TYPE=wayland
export BAT_THEME="Monokai Extended Bright"

# PATH nền tảng
export PATH="/usr/local/bin:/usr/bin:/bin:$HOME/.local/bin:$HOME/bin:$PATH"

# Snap
export PATH="$PATH:/snap/bin"

# Android SDK
export ANDROID_HOME="$HOME/Android"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

# Java (JDK)
export JAVA_HOME="$HOME/.local/share/mise/installs/java/26.0.1"
export PATH="$JAVA_HOME/bin:$PATH"

# Chrome (từ Windows)
export CHROME_EXECUTABLE="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"

# SQL Server tools
export PATH="$PATH:/opt/mssql-tools18/bin"

# Claude Code (qua OpenRouter)
# export OPENROUTER_API_KEY="<your-openrouter-api-key>"
export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
# export ANTHROPIC_AUTH_TOKEN="<your-openrouter-api-key>"
export ANTHROPIC_API_KEY=""
export ANTHROPIC_MODEL="qwen/qwen3-coder:free"

# Hermes Agent x Obsidian
export OBSIDIAN_VAULT="/mnt/d/SecondBrain"

# ====== 2. Zinit ======
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# ====== 3. Plugins ======
zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid atload'ZINIT[COMPINIT_OPTS]=-C; zpcompinit'
zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid
zinit light hlissner/zsh-autopair
zinit ice wait lucid atload'zicompinit; zicdreplay'
zinit load zchee/zsh-completions

# mise (version manager)
zinit ice as"command" from"gh-r" extract'!' mv"mise* -> mise" pick"mise" atload'eval "$(mise activate zsh)"'
zinit light jdx/mise
export MISE_TRUSTED_CONFIG_PATHS="$HOME/workspace"

# Powerlevel10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# ====== 4. Plugin config & Completion ======
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit
compinit -d ~/.zsh/compdump

# ====== 5. Aliases ======
alias ..='cd .. && clear && la'
alias ...='cd ../.. && clear && la'
alias ....='cd ../../.. && clear && la'
alias ~='cd ~ && clear && la'
alias clr='clear && la'

# ====== 6. Modern CLI ======
alias ls='eza --icons=always --group-directories-first'
alias ll='eza -l --icons=always --group-directories-first --git'
alias la='eza -a --icons=always --group-directories-first'
alias tree='eza --tree --icons=always'
alias cat='batcat --paging=never'
alias grep='rg --smart-case'
alias find='fdfind'
alias y='yazi'

eval "$(zoxide init zsh)"
export TEALDEER_CACHE_DIR="$HOME/.cache/tealdeer"

# Custom zoxide
if typeset -f __zoxide_z >/dev/null 2>&1; then
    z() {
        if [ $# -eq 0 ]; then
            __zoxide_z
        else
            __zoxide_z "$@"
            local ret=$?
            if [ $ret -eq 0 ]; then clear && la; fi
            return $ret
        fi
    }
fi

c() {
    if [ $# -eq 0 ]; then cd ~ && clear && la
    else cd "$@" && clear && la; fi
}

# ====== 7. fzf ======
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "
  if [ -d {} ]; then
    eza --tree --icons=always --color=always {}
  else
    batcat --style=numbers --color=always {}
  fi"'
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# ====== 8. SSH Agent ======
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if ! ssh-add -l > /dev/null 2>&1; then
    rm -f "$SSH_AUTH_SOCK"
    ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
    ssh-add -q ~/.ssh/id_ed25519 2>/dev/null
fi

# ====== 9. AI Coding Agents (workspace-only) ======
alias freebuff="mise exec -- npx --no-install freebuff"
# openclaude giữ biến môi trường trong alias để tránh xung đột với các agent khác (Qwen, Hermes...)
alias openclaude="OPENAI_BASE_URL=http://localhost:3101/v1 OPENAI_API_KEY=freellmapi-98f9e99c599961adba277d43a25c3c156b1cede232097aea CLAUDE_CODE_USE_OPENAI=1 mise exec -- npx --no-install openclaude"
alias opencode="mise exec -- npx --no-install opencode"
alias openclaw="mise exec -- npx --no-install openclaw"
alias qwen="mise exec -- npx --no-install qwen"
alias codegraph="mise exec -- npx --no-install codegraph"
alias cline="mise exec -- npx --no-install cline"

# ====== 10. Auto-switch to mise inside workspace ======
node() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- node "$@"
    else
        command node "$@"
    fi
}
npm() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- npm "$@"
    else
        command npm "$@"
    fi
}
npx() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- npx "$@"
    else
        command npx "$@"
    fi
}
go() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- go "$@"
    else
        command go "$@"
    fi
}
python() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- python "$@"
    else
        command python "$@"
    fi
}
python3() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- python3 "$@"
    else
        command python3 "$@"
    fi
}
pip() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- pip "$@"
    else
        command pip "$@"
    fi
}
pip3() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- pip3 "$@"
    else
        command pip3 "$@"
    fi
}
dotnet() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- dotnet "$@"
    else
        command dotnet "$@"
    fi
}
java() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- java "$@"
    else
        command java "$@"
    fi
}
javac() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- javac "$@"
    else
        command javac "$@"
    fi
}
flutter() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- flutter "$@"
    else
        command flutter "$@"
    fi
}
dart() {
    if [[ "$PWD" == "$HOME/workspace"* ]]; then
        mise exec -- dart "$@"
    else
        command dart "$@"
    fi
}

# ====== 11. Broot ======
source /home/razer_admin/.config/broot/launcher/bash/br

# OpenClaw Completion
[ -f "/home/razer_admin/.openclaw/completions/openclaw.zsh" ] && source "/home/razer_admin/.openclaw/completions/openclaw.zsh"
