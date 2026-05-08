#!/bin/bash
set -e

ENVIRONMENT=${1:-"python"}

# Install dependencies
apt-get update && apt-get install -y stow git neovim lazygit

# Dotfiles
git clone https://github.com/alejosilvalau/dotfiles ~/.dotfiles
cd ~/.dotfiles
bash stow-dev-container.sh

# Nvim config
git clone https://github.com/alejosilvalau/nvim-config-custom ~/.config/nvim

# Set environment in nvim
sed -i "s/return environments\.\w*/return environments.${ENVIRONMENT}/" ~/.config/nvim/lua/environments.lua

echo "✅ Container setup complete for environment: ${ENVIRONMENT}"
