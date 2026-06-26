# =============================================================================
# Custom Functions
# =============================================================================

# Smart cd: clears and lists on directory change
function c() {
	cd "$@" && clear && ll
}

# Create directory and cd into it
function mkcd() {
	mkdir -p "$1" && cd "$1"
}

# Extract any archive
function extract() {
	if [ -f "$1" ]; then
		case "$1" in
			*.tar.bz2)  tar xjf "$1"      ;;
			*.tar.gz)   tar xzf "$1"      ;;
			*.bz2)      bunzip2 "$1"      ;;
			*.rar)      unrar x "$1"      ;;
			*.gz)       gunzip "$1"       ;;
			*.tar)      tar xf "$1"       ;;
			*.tbz2)     tar xjf "$1"      ;;
			*.tgz)      tar xzf "$1"      ;;
			*.zip)      unzip "$1"        ;;
			*.Z)        uncompress "$1"    ;;
			*.7z)       7z x "$1"         ;;
			*)          echo "Can't extract '$1'" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# Find file with fzf preview (if available)
function spot() {
	local find_cmd
	if command -v fdfind &>/dev/null; then
		find_cmd="fdfind"
	elif command -v fd &>/dev/null; then
		find_cmd="fd"
	else
		find_cmd="find"
	fi

	local pager
	if command -v batcat &>/dev/null; then
		pager="batcat"
	elif command -v bat &>/dev/null; then
		pager="bat"
	else
		pager="cat"
	fi

	if [ -t 1 ] && command -v fzf &>/dev/null; then
		$find_cmd --type f "$@" 2>/dev/null | fzf --preview "
			if file --mime {} | grep -q text; then
				$pager --style=numbers --color=always {} 2>/dev/null || cat {}
			fi
		" --preview-window=right:60%
	else
		$find_cmd --type f "$@" 2>/dev/null
	fi
}

# Quick server
function serve() {
	local port="${1:-8000}"
	python3 -m http.server "$port"
}

# Weather
function weather() {
	curl -s "wttr.in/${1:-Ho+Chi+Minh}?format=3"
}
