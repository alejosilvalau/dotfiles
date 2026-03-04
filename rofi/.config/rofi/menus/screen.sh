#!/bin/bash
# ~/.config/rofi/menus/audio.sh
THEME="$HOME/.config/rofi/tokyonight.rasi"
ROFI="rofi -dmenu -i -theme $THEME"

options=(
  "󰃞  Brightness"
  "󰘚  GPU Mode"
  "󰍹  Refresh Rate"
  "󰅙  Close"
)

menu=$(printf '%s\n' "${options[@]}")
chosen=$(echo "$menu" | $ROFI \
  -p "Screen" \
  -no-custom \
  -format 'i:s')

[ -z "$chosen" ] && exit

label=$(echo "$chosen" | cut -d: -f2-)
case "$label" in
*"Brightness"*)
  ~/.config/rofi/menus/screen-brightness.sh
  ;;
*"GPU Mode"*)
  ~/.config/rofi/menus/gpu-mode.sh
  ;;
*"Refresh Rate"*)
  ~/.config/rofi/menus/refresh-rate.sh
  ;;
*"Close"*)
  exit
  ;;
*"───"* | "")
  # Header or blank line selected — reopen menu
  exec "$0"
  ;;
esac
