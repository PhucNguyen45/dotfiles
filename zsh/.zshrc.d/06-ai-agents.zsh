# =============================================================================
# AI Coding Agents (workspace-only)
# =============================================================================

# These agents run via 'mise exec' to use workspace tool versions

# Freebuff
alias freebuff="mise exec -- npx --no-install freebuff"

# openclaude - uses local free LLM API proxy
# Set OPENAI_API_KEY in your .env or exports if needed
alias openclaude="OPENAI_BASE_URL=http://localhost:3101/v1 CLAUDE_CODE_USE_OPENAI=1 mise exec -- npx --no-install openclaude"

# Other AI agents
alias opencode="mise exec -- npx --no-install opencode"
alias openclaw="mise exec -- npx --no-install openclaw"
alias qwen="mise exec -- npx --no-install qwen"
alias codegraph="mise exec -- npx --no-install codegraph"
alias cline="mise exec -- npx --no-install cline"
alias kilo="mise exec -- npx --no-install kilo"
