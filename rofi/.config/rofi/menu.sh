#!/bin/bash
# ~/.config/rofi/menu.sh

THEME="$HOME/.config/rofi/tokyonight.rasi"
ROFI="rofi -dmenu -i -theme $THEME"

options=(
  "󰀻  Launcher"
  "󰄀  Screenshot"
  "󰝚  Music"
  "󰱨  Emoji"
  "󰍹  Screen"
  "󰕾  Audio"
  "󰤨  Network"
  "󰐥  Power"
  "󰅙  Close"
)

menu=$(printf '%s\n' "${options[@]}")
chosen=$(echo "$menu" | $ROFI \
  -p "Menu" \
  -no-custom \
  -format 'i:s')

[ -z "$chosen" ] && exit

label=$(echo "$chosen" | cut -d: -f2-)
case "$label" in
*"Launcher"*)
  rofi -show drun -theme "$THEME" -p "  Launch"
  ;;
*"Screenshot"*)
  flameshot gui
  ;;
*"Music"*)
  kitty -e termusic
  ;;
*"Emoji"*)
  rofimoji --selector-args="-theme $THEME" --clipboarder xclip --action copy
  ;;
*"Screen"*)
  ~/.config/rofi/menus/screen.sh
  ;;
*"Audio"*)
  kitty -e pulsemixer
  ;;
*"Network"*)
  ~/.config/rofi/menus/network.sh
  ;;
*"Power"*)
  ~/.config/rofi/menus/power.sh
  ;;
*"Close"*)
  exit
  ;;
*"───"* | "")
  # Header or blank line selected — reopen menu
  exec "$0"
  ;;
esac
