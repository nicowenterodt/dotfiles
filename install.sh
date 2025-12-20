#!/bin/bash

# Exit on error, undefined variables
set -e
set -u

# Detect script directory dynamically
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES="$SCRIPT_DIR"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y-%m-%d_%H-%M-%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}➜${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }

# Backup function
backup_if_exists() {
  local target="$1"
  local name="$2"

  # Skip if target doesn't exist
  if [[ ! -e "$target" && ! -L "$target" ]]; then
    return 0
  fi

  # Skip if already a symlink pointing to our dotfiles
  if [[ -L "$target" ]]; then
    local link_target
    link_target="$(readlink "$target")"
    if [[ "$link_target" == "$DOTFILES"* ]]; then
      return 0
    fi
  fi

  # Create backup directory if needed
  mkdir -p "$BACKUP_DIR"

  # Backup the file/directory
  print_info "Backing up existing $name to $BACKUP_DIR"
  cp -r "$target" "$BACKUP_DIR/$(basename "$target")"
}

# Safe symlink function
safe_symlink() {
  local source="$1"
  local target="$2"
  local name="$3"

  # Check if source exists
  if [[ ! -e "$source" ]]; then
    print_warning "Source $source does not exist, skipping"
    return 1
  fi

  # Backup existing target if needed
  backup_if_exists "$target" "$name"

  # Create parent directory if needed
  local target_dir
  target_dir="$(dirname "$target")"
  mkdir -p "$target_dir"

  # Create symlink
  ln -sf "$source" "$target"

  # Verify symlink was created successfully
  if [[ -L "$target" ]]; then
    print_success "Linked $name"
    return 0
  else
    print_error "Failed to link $name"
    return 1
  fi
}

# Dependency checks
check_dependencies() {
  print_info "Checking dependencies..."

  local missing_deps=()

  # Check for curl
  if ! command -v curl &>/dev/null; then
    missing_deps+=("curl")
  fi

  # Check for git
  if ! command -v git &>/dev/null; then
    missing_deps+=("git")
  fi

  if [[ ${#missing_deps[@]} -gt 0 ]]; then
    print_error "Missing required dependencies: ${missing_deps[*]}"
    print_info "Please install missing dependencies and try again"
    exit 1
  fi

  # Check for Homebrew (optional but recommended)
  if ! command -v brew &>/dev/null; then
    print_warning "Homebrew not found. Package installation will be skipped."
    print_info "Install Homebrew from https://brew.sh"
  else
    print_success "All dependencies found"
  fi
}

# Main installation
main() {
  echo "Setting up dotfiles..."
  echo ""

  # Check dependencies
  check_dependencies
  echo ""

  # Oh My Zsh (install if not present)
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    print_info "Installing Oh My Zsh..."
    if sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
      print_success "Oh My Zsh installed"
    else
      print_error "Failed to install Oh My Zsh"
      exit 1
    fi
  else
    print_success "Oh My Zsh already installed"
  fi
  echo ""

  # Zsh configuration
  print_info "Setting up Zsh configuration..."
  safe_symlink "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc" ".zshrc"
  safe_symlink "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile" ".zprofile"
  safe_symlink "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh" ".p10k.zsh"
  echo ""

  # Git configuration
  print_info "Setting up Git configuration..."
  safe_symlink "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig" ".gitconfig"
  safe_symlink "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global" ".gitignore_global"

  # Ensure repo-local gitconfig.local exists
  mkdir -p "$DOTFILES/git"
  if [[ ! -f "$DOTFILES/git/.gitconfig.local" ]]; then
    if [[ -f "$DOTFILES/git/.gitconfig.local.example" ]]; then
      cp "$DOTFILES/git/.gitconfig.local.example" "$DOTFILES/git/.gitconfig.local"
      print_info "Created .gitconfig.local from example"
    else
      : > "$DOTFILES/git/.gitconfig.local"
      print_info "Created empty .gitconfig.local"
    fi
  fi
  safe_symlink "$DOTFILES/git/.gitconfig.local" "$HOME/.gitconfig.local" ".gitconfig.local"
  echo ""

  # WezTerm
  print_info "Setting up WezTerm configuration..."
  safe_symlink "$DOTFILES/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua" "wezterm.lua"
  echo ""

  # Karabiner Elements
  print_info "Setting up Karabiner Elements configuration..."
  safe_symlink "$DOTFILES/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json" "karabiner.json"
  echo ""

  # Neovim
  print_info "Setting up Neovim configuration..."
  safe_symlink "$DOTFILES/nvim" "$HOME/.config/nvim" "nvim"
  echo ""

  # VS Code
  print_info "Setting up VS Code configuration..."
  safe_symlink "$DOTFILES/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json" "VS Code settings.json"

  # VS Code keybindings (if exists)
  if [[ -f "$DOTFILES/vscode/keybindings.json" ]]; then
    safe_symlink "$DOTFILES/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json" "VS Code keybindings.json"
  fi
  echo ""

  # Homebrew packages
  if command -v brew &>/dev/null; then
    print_info "Installing Homebrew packages..."
    if brew bundle --file="$DOTFILES/Brewfile"; then
      print_success "Homebrew packages installed"
    else
      print_warning "Some Homebrew packages may have failed to install"
    fi
  fi
  echo ""

  # Post-install validation
  print_info "Validating installation..."
  local validation_failed=0

  # Check critical symlinks
  local symlinks=(
    "$HOME/.zshrc"
    "$HOME/.zprofile"
    "$HOME/.gitconfig"
    "$HOME/.config/wezterm/wezterm.lua"
    "$HOME/.config/karabiner/karabiner.json"
    "$HOME/.config/nvim"
  )

  for symlink in "${symlinks[@]}"; do
    if [[ ! -L "$symlink" ]]; then
      print_error "Symlink missing: $symlink"
      validation_failed=1
    fi
  done

  if [[ $validation_failed -eq 0 ]]; then
    print_success "All symlinks validated successfully"
  else
    print_error "Some symlinks failed validation"
  fi
  echo ""

  # Summary
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  print_success "Dotfiles setup complete!"
  echo ""
  if [[ -d "$BACKUP_DIR" ]]; then
    print_info "Backups saved to: $BACKUP_DIR"
  fi
  print_info "Restart your terminal to apply changes"
  print_info "To switch Karabiner profiles: Open Karabiner-Elements > Profiles"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Run main function
main
