#!/bin/bash
# ~/.config/rofi/menus/network.sh
THEME="$HOME/.config/rofi/tokyonight.rasi"
ROFI="rofi -dmenu -i -theme $THEME"

options=(
  "󰤨  WiFi"
  "󰂯  Bluetooth"
  "󰅙  Close"
)

menu=$(printf '%s\n' "${options[@]}")
chosen=$(echo "$menu" | $ROFI \
  -p "Network" \
  -no-custom \
  -format 'i:s')

[ -z "$chosen" ] && exit

label=$(echo "$chosen" | cut -d: -f2-)
case "$label" in
*"WiFi"*)
  ghostty -e wifitui
  ;;
*"Bluetooth"*)
  ghostty -e bluetui
  ;;
*"Close"*)
  exit
  ;;
*"───"* | "")
  # Header or blank line selected — reopen menu
  exec "$0"
  ;;
esac
