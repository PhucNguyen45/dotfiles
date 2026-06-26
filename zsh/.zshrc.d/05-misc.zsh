# =============================================================================
# Miscellaneous / AI Agents / Broot
# =============================================================================

# Broot
if [ -f "$HOME/.config/broot/launcher/bash/br" ]; then
	source "$HOME/.config/broot/launcher/bash/br"
fi

# OpenClaw completions (for this workspace)
if command -v openclaw &>/dev/null; then
	# Source completions if available
	:
fi

# Use bat as man page colorizer
if command -v batcat &>/dev/null; then
	export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
elif command -v bat &>/dev/null; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# tldr (if installed)
if command -v tldr &>/dev/null; then
	alias help='tldr'
fi
