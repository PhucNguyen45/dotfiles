# =============================================================================
# SSH Agent
# =============================================================================

# Start ssh-agent if not running
if [ -z "$SSH_AUTH_SOCK" ] || [ ! -S "$SSH_AUTH_SOCK" ]; then
	SSH_SOCK="$HOME/.ssh/agent.sock"
	if [ -S "$SSH_SOCK" ]; then
		export SSH_AUTH_SOCK="$SSH_SOCK"
	else
		eval "$(ssh-agent -s -a "$SSH_SOCK" 2>/dev/null)" > /dev/null
	fi
fi

# Load keys
ssh-add -l &>/dev/null || ssh-add -q ~/.ssh/id_ed25519 2>/dev/null || true
