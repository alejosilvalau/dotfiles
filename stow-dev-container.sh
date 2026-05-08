#!/bin/bash
# Stow dotfiles for dev container setup
# Usage: cd dotfiles && ./stow-dev-container.sh

set -e

# Packages to stow for dev container
PACKAGES=(
  "bashrc"
  "omakub"
  "prettierrc"
  "profile"
  "tmux"
  "tmux-sessionizer"
  "scripts"
)

echo "🔗 Stowing packages..."

for package in "${PACKAGES[@]}"; do
  if [ -d "$package" ]; then
    echo "  ✓ Stowing $package"
    stow "$package"
  else
    echo "  ✗ Warning: $package not found, skipping"
  fi
done

echo "✅ Stow complete!"
