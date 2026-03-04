#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <package>"
  exit 1
fi
package="$1"
mkdir -p "$package/.config/$package" && mv "$HOME/.config/$package"/* "$HOME/dotfiles/$package/.config/$package" && stow "$package"
