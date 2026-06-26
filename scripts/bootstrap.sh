#!/bin/bash
# =============================================================================
# Dotfiles Bootstrap Script
# =============================================================================
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/PhucNguyen45/dotfiles/main/scripts/bootstrap.sh | bash
#   ./scripts/bootstrap.sh
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

detect_os() {
	if [ "$(uname)" = "Darwin" ]; then
		echo "macos"
	elif grep -qi "ubuntu\\|debian" /etc/os-release 2>/dev/null; then
		echo "debian"
	elif grep -qi "fedora\\|rhel\\|centos" /etc/os-release 2>/dev/null; then
		echo "rhel"
	elif [ -f /etc/alpine-release ]; then
		echo "alpine"
	else
		echo "unknown"
	fi
}

install_packages() {
	local os="$(detect_os)"
	info "Detected OS: $os"

	case "$os" in
		debian)
			info "Updating package lists..."
			sudo apt-get update -qq

			info "Installing essential packages..."
			sudo apt-get install -y \
				fd-find \
				git curl wget \
				tmux vim \
				eza \
				bat \
				fzf \
				rg ripgrep \
				btop htop \
				tree \
				zsh \
				atuin \
				|| warn "Some packages failed to install"
			;;
		macos)
			if command -v brew &>/dev/null; then
				info "Installing with Homebrew..."
				brew install \
					git tmux vim \
					fzf ripgrep eza \
					btop htop bat \
					tree zsh \
					lazygit zoxide \
					atuin starship \
					|| warn "Some packages failed to install"
			else
				warn "Homebrew not installed. Visit https://brew.sh"
			fi
			;;
		*)
			warn "Unknown OS. Install packages manually."
			;;
	esac

	# Install starship (cross-platform)
	if ! command -v starship &>/dev/null; then
		info "Installing Starship prompt..."
		curl -fsSL https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || warn "Starship install failed"
	fi

	success "Package installation complete!"
}

install_symlinks() {
	info "Creating symlinks..."
	"$DOTFILES_DIR/scripts/symlink.sh" install
}

setup_shell() {
	if command -v zsh &>/dev/null; then
		if [ "$SHELL" != "$(which zsh)" ]; then
			info "Changing default shell to Zsh..."
			chsh -s "$(which zsh)"
			success "Default shell changed to Zsh. Log out and back in."
		else
			info "Zsh is already the default shell."
		fi
	fi
}

main() {
	echo ""
	echo "  D O T F I L E S   B O O T S T R A P"
	echo "  github.com/PhucNguyen45/dotfiles"
	echo ""

	case "${1:-all}" in
		all)       install_packages; install_symlinks; setup_shell ;;
		packages)  install_packages ;;
		symlinks)  install_symlinks ;;
		shell)     setup_shell ;;
		*)         echo "Usage: $0 [all|packages|symlinks|shell]"; exit 1 ;;
	esac

	success "Bootstrap complete!"
	echo ""
}

main "$@"
