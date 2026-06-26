# =============================================================================
# Environment Variables
# =============================================================================

# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000
HISTDUP=erase
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history
setopt append_history
setopt inc_append_history
setopt extended_history

# Default editor
export EDITOR="nano"
export VISUAL="$EDITOR"

# Bat theme
export BAT_THEME="Dracula"

# XDG settings
export XDG_SESSION_TYPE="x11"

# Android SDK
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"

# Java (managed by mise)
export JAVA_HOME="$HOME/.local/share/mise/installs/java/current"

# Chrome path (WSL2)
export CHROME_PATH="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
