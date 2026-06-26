# =============================================================================
#  .zshrc - WSL Ubuntu 26.04
#  Zinit + Powerlevel10k + mise + Modern CLI (Modular)
# =============================================================================

# ----- Powerlevel10k Instant Prompt -----
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Plugins & Core
# =============================================================================

# --- Zinit ---
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
	zdharma-continuum/zinit-annex-as-monitor \
	zdharma-continuum/zinit-annex-bin-gem-node \
	zdharma-continuum/zinit-annex-patch-dl \
	zdharma-continuum/zinit-annex-rust

# --- Plugins ---
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

# --- Plugin Config & Completion ---
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

# =============================================================================
# Source modular configs
# =============================================================================

ZSH_MODULES="$HOME/.dotfiles/zsh/.zshrc.d"

# Source all module files in order
for module in $(ls "$ZSH_MODULES"/*.zsh 2>/dev/null | sort); do
	[ -f "$module" ] && source "$module"
done

# =============================================================================
# Atuin (syncable shell history)
# =============================================================================
if command -v atuin &>/dev/null; then
	eval "$(atuin init zsh)"
fi

# =============================================================================
# Starship (fallback prompt - p10k takes precedence)
# =============================================================================
# Starship can be enabled for non-p10k terminals or bash
# eval "$(starship init zsh)"
