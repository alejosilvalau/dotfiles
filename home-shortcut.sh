#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <package> <file_name>"
  exit 1
fi
package="$1"
file_name="$2"
mkdir -p "$package" && mv "$HOME/$file_name" "$HOME/dotfiles/$package" && stow "$package"
