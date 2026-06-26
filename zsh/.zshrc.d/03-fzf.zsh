# =============================================================================
# fzf Configuration
# =============================================================================

# Default options
if command -v fzf &>/dev/null; then
	export FZF_DEFAULT_OPTS=" \
		--color=bg+:#363a4f,bg:#1e1e2e,spinner:#f5a97f,hl:#8aadf4 \
		--color=fg:#cad3f5,header:#8aadf4,info:#c6a0f6,pointer:#f5a97f \
		--color=marker:#f5a97f,fg+:#cad3f5,prompt:#c6a0f6,hl+:#8aadf4 \
		--layout=reverse \
		--border \
		--height=80% \
		--preview-window=right:60%"

	# Use rg as default source
	export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!.git/*" 2>/dev/null || find . -type f 2>/dev/null | head -1000'

	# Keybindings
	source /usr/share/doc/fzf/examples/key-bindings.zsh 2>/dev/null || true

	# Completion
	source /usr/share/doc/fzf/examples/completion.zsh 2>/dev/null || true
fi
