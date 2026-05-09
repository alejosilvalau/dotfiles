#!/bin/bash
set -e

ENVIRONMENT=${1:-"python"}

# Install dependencies
# nodejs python3-pip npm
#
apt-get update && apt-get install -y stow git lazygit tmux unzip curl build-essential
curl -fsSL https://fnm.vercel.app/install | bash
curl -fsSL https://opencode.ai/install | bash

# Neovim

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz
sudo cp nvim-linux-x86_64/bin/nvim /usr/bin/nvim
sudo cp -r nvim-linux-x86_64/lib/nvim /usr/lib/
sudo cp -r nvim-linux-x86_64/share/nvim /usr/share/

# Dotfiles
git clone https://github.com/alejosilvalau/dotfiles ~/.dotfiles
cd ~/.dotfiles
bash stow-dev-container.sh

# Node
fnm install --lts && fnm use lts/latest

# Nvim config
git clone https://github.com/alejosilvalau/nvim-config-custom ~/.config/nvim

# Opencode config
git clone https://github.com/alejosilvalau/opencode-config ~/.config/opencode

# Set environment in nvim
sed -i "s/return environments\.\w*/return environments.${ENVIRONMENT}/" ~/.config/nvim/lua/environments.lua

echo "✅ Container setup complete for environment: ${ENVIRONMENT}"
