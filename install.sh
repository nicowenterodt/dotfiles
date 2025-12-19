#!/bin/bash
DOTFILES=~/dotfiles

echo "☕ Setting up dotfiles..."

# Zsh
ln -sf $DOTFILES/zsh/.zshrc ~/.zshrc
ln -sf $DOTFILES/zsh/.zprofile ~/.zprofile
ln -sf $DOTFILES/zsh/.p10k.zsh ~/.p10k.zsh

# Git
ln -sf $DOTFILES/git/.gitconfig ~/.gitconfig
ln -sf $DOTFILES/git/.gitignore_global ~/.gitignore_global

# Ensure repo-local gitconfig.local exists (copy from example) and link it to HOME
mkdir -p "$DOTFILES/git"
if [[ ! -f "$DOTFILES/git/.gitconfig.local" ]]; then
  if [[ -f "$DOTFILES/git/.gitconfig.local.example" ]]; then
    cp "$DOTFILES/git/.gitconfig.local.example" "$DOTFILES/git/.gitconfig.local"
  else
    : > "$DOTFILES/git/.gitconfig.local"
  fi
fi
ln -sf "$DOTFILES/git/.gitconfig.local" "$HOME/.gitconfig.local"

# WezTerm
mkdir -p ~/.config/wezterm
ln -sf $DOTFILES/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

# Karabiner Elements
mkdir -p ~/.config/karabiner
ln -sf $DOTFILES/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

# Neovim
mkdir -p ~/.config
ln -sf $DOTFILES/nvim ~/.config/nvim

# Homebrew packages
if command -v brew &>/dev/null; then
  brew bundle --file=$DOTFILES/Brewfile
fi

echo "Done! Restart your terminal."
