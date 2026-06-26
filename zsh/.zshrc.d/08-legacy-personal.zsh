# =============================================================================
# Legacy Personal Overrides
# =============================================================================
# Module nay chua cac thiet lap ca nhan & thoi quen terminal cu.
# - OVERRIDE cac alias/env vars tu module truoc (00-07) ve behavior cu
# - Chua cac thong tin nhay cam (API keys, paths ca nhan)
# =============================================================================

# ======================== ENV VARS (override) ========================

# Bat theme — Monokai (quen mat)
export BAT_THEME="Monokai Extended Bright"

# XDG settings — WSL2 (wayland + NO_AT_BRIDGE cho clipboard on WSL2)
export NO_AT_BRIDGE=1
export XDG_SESSION_TYPE="wayland"

# PATH mo rong
export PATH="/usr/local/bin:/usr/bin:/bin:$HOME/.local/bin:$HOME/bin:$PATH"
export PATH="$PATH:/snap/bin"

# Android SDK (path cu: $HOME/Android, khong phai /Sdk)
export ANDROID_HOME="$HOME/Android"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

# Chrome (WSL2) — ten bien cu
export CHROME_EXECUTABLE="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"

# SQL Server tools
export PATH="$PATH:/opt/mssql-tools18/bin"

# Claude Code (qua OpenRouter)
export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
export ANTHROPIC_API_KEY=""
export ANTHROPIC_MODEL="qwen/qwen3-coder:free"

# Hermes Agent x Obsidian
export OBSIDIAN_VAULT="/mnt/d/SecondBrain"

# Tealdeer (tldr client)
export TEALDEER_CACHE_DIR="$HOME/.cache/tealdeer"

# ======================== ALIASES (override) ========================

# Navigation — auto clear + la (thoi quen cu)
alias ..='cd .. && clear && la'
alias ...='cd ../.. && clear && la'
alias ....='cd ../../.. && clear && la'
alias ~='cd ~ && clear && la'
alias clr='clear && la'

# Modern CLI — icons + group-dir-first (thoi quen cu)
alias ls='eza --icons=always --group-directories-first'
alias ll='eza -l --icons=always --group-directories-first --git'
alias la='eza -a --icons=always --group-directories-first'
alias l='eza --icons=always --group-directories-first'
alias tree='eza --tree --icons=always'
alias cat='batcat --paging=never'
alias grep='rg --smart-case'
alias find='fdfind'

# ======================== FUNCTIONS (override) ========================

# c() — cd roi clear + la (dung la thay vi ll, xu ly $# -eq 0)
function c() {
	if [ $# -eq 0 ]; then
		cd ~ && clear && la
	else
		cd "$@" && clear && la
	fi
}

# ======================== ZOXIDE ========================
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh)"

	# Custom z() — auto clear + la sau khi cd
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

# ======================== OPENCLAW COMPLETIONS ========================
if [ -f "$HOME/.openclaw/completions/openclaw.zsh" ]; then
	source "$HOME/.openclaw/completions/openclaw.zsh"
fi
