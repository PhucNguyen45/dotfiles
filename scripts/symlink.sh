#!/bin/bash
# =============================================================================
# Dotfiles Symlink Manager
# =============================================================================
# This script manages symbolic links from your home directory (~) to the
# dotfiles repository (~/.dotfiles).
#
# Usage:
#   ./scripts/symlink.sh [install|remove|status]
#
#   install   - Create all symlinks (default)
#   remove    - Remove all symlinks created by this script
#   status    - Show current symlink status
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$DOTFILES_DIR/backups"

# Define all dotfile mappings (source -> target in $HOME)
# Format: "source_path:target_name"
declare -a MAPPINGS=(
	"zsh/.zshrc:.zshrc"
	"zsh/.zprofile:.zprofile"
	"bash/.bashrc:.bashrc"
	"bash/.profile:.profile"
	"git/.gitconfig:.gitconfig"
	"git/.gitignore_global:.gitignore_global"
	"tmux/.tmux.conf:.tmux.conf"
	"vim/.vimrc:.vimrc"
	"starship/starship.toml:.config/starship.toml"
)

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

install_symlinks() {
	info "Creating symlinks from $DOTFILES_DIR to $HOME..."

	for mapping in "${MAPPINGS[@]}"; do
		local source_path="${mapping%%:*}"
		local target_name="${mapping#*:}"
		local source_full="$DOTFILES_DIR/$source_path"
		local target_full="$HOME/$target_name"

		if [ ! -f "$source_full" ] && [ ! -d "$source_full" ]; then
			warn "Source not found: $source_full (skipping)"
			continue
		fi

		# Ensure target directory exists
		mkdir -p "$(dirname "$target_full")"

		if [ -L "$target_full" ]; then
			local link_target="$(readlink "$target_full")"
			if [ "$link_target" = "$source_full" ]; then
				success "Already linked: $target_name -> $source_path"
				continue
			else
				info "Re-linking: $target_name (was -> $link_target)"
				rm "$target_full"
			fi
		elif [ -f "$target_full" ] || [ -d "$target_full" ]; then
			mkdir -p "$BACKUP_DIR/$(dirname "$target_name")"
			cp "$target_full" "$BACKUP_DIR/$target_name"
			info "Backed up: $target_name"
			rm -rf "$target_full"
		fi

		ln -s "$source_full" "$target_full"
		success "Linked: $source_path -> ~/$target_name"
	done

	info "Backups saved to: $BACKUP_DIR"
}

remove_symlinks() {
	info "Removing symlinks..."

	for mapping in "${MAPPINGS[@]}"; do
		local target_name="${mapping#*:}"
		local target_full="$HOME/$target_name"

		if [ -L "$target_full" ]; then
			rm "$target_full"
			success "Removed: ~/$target_name"
		fi
	done
}

show_status() {
	info "Symlink status:"

	for mapping in "${MAPPINGS[@]}"; do
		local source_path="${mapping%%:*}"
		local target_name="${mapping#*:}"
		local source_full="$DOTFILES_DIR/$source_path"
		local target_full="$HOME/$target_name"

		if [ -L "$target_full" ]; then
			local link_target="$(readlink "$target_full")"
			if [ "$link_target" = "$source_full" ]; then
				success "~/$target_name -> $source_path"
			else
				warn "~/$target_name -> $link_target (wrong target!)"
			fi
		elif [ -f "$target_full" ] || [ -d "$target_full" ]; then
			error "~/$target_name (regular file)"
		else
			error "~/$target_name (not found)"
		fi
	done
}

case "${1:-install}" in
	install) install_symlinks ;;
	remove)  remove_symlinks ;;
	status)  show_status ;;
	*)       echo "Usage: $0 [install|remove|status]"; exit 1 ;;
esac
