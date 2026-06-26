#!/bin/bash
# =============================================================================
# Dotfiles Bootstrap Script
# =============================================================================
# This script sets up a new machine with the dotfiles configuration.
# It installs essential tools and creates symlinks.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/PhucNguyen45/dotfiles/main/scripts/bootstrap.sh | bash
#   # OR
#   ./scripts/bootstrap.sh
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Function to detect OS
detect_os() {
	if [ "$(uname)" = "Darwin" ]; then
		echo "macos"
	elif grep -qi "ubuntu\|debian" /etc/os-release 2>/dev/null; then
		echo "debian"
	elif grep -qi "fedora\|rhel\|centos" /etc/os-release 2>/dev/null; then
		echo "rhel"
	elif [ -f /etc/alpine-release ]; then
		echo "alpine"
	else
		echo "unknown"
	fi
}

# Install system packages
install_packages() {
	local os="$(detect_os)"
	info "Detected OS: $os"

	case "$os" in
		debian)
			info "Updating package lists..."
			sudo apt-get update -qq

			info "Installing essential packages..."
			sudo apt-get install -y \
				git curl wget \
				tmux \
				vim \
				fzf \
				rg ripgrep \
				eza \
				btop \
				htop \
				bat \
				tree \
				zsh \
				|| warn "Some packages failed to install (may not be available)"
			;;
		macos)
			if command -v brew &> /dev/null; then
				info "Installing with Homebrew..."
				brew install \
					git tmux vim \
					fzf ripgrep eza \
					btop htop bat \
					tree zsh \
					lazygit \
					zoxide \
					|| warn "Some packages failed to install"
			else
				warn "Homebrew not installed. Install it from https://brew.sh"
			fi
			;;
		*)
			warn "Unknown OS. Please install packages manually."
			;;
	esac

	success "Package installation complete!"
}

# Create symlinks
install_symlinks() {
	info "Creating symlinks..."
	"$DOTFILES_DIR/scripts/symlink.sh" install
}

# Setup Zsh as default shell (if not already)
setup_shell() {
	if command -v zsh &> /dev/null; then
		local current_shell="$SHELL"
		if [ "$current_shell" != "$(which zsh)" ]; then
			info "Changing default shell to Zsh..."
			chsh -s "$(which zsh)"
			success "Default shell changed to Zsh. Please log out and back in."
		else
			info "Zsh is already the default shell."
		fi
	fi
}

# Main
main() {
	echo ""
	echo "  ╔═══════════════════════════════════════╗"
	echo "  ║     Dotfiles Bootstrap                ║"
	echo "  ║     github.com/PhucNguyen45/dotfiles  ║"
	echo "  ╚═══════════════════════════════════════╝"
	echo ""

	case "${1:-all}" in
		all)
			install_packages
			install_symlinks
			setup_shell
			;;
		packages)
			install_packages
			;;
		symlinks)
			install_symlinks
			;;
		shell)
			setup_shell
			;;
		*)
			echo "Usage: $0 [all|packages|symlinks|shell]"
			exit 1
			;;
	esac

	success "Bootstrap complete!"
	echo ""
	echo "  Next steps:"
	echo "  1. Restart your terminal"
	echo "  2. Run 'tmux' to try the tmux config"
	echo "  3. Run 'git lg' to test git aliases"
	echo ""
}

main "$@"
