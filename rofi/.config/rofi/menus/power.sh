#!/bin/bash
# ~/.config/rofi/menus/power.sh
THEME="$HOME/.config/rofi/tokyonight.rasi"
ROFI="rofi -dmenu -i -theme $THEME"

options=(
  "󰌾  Lock Screen"
  "󰍃  Log Out"
  "󰜉  Restart"
  "󰐥  Shut Down"
  "󰅙  Close"
)

menu=$(printf '%s\n' "${options[@]}")
chosen=$(echo "$menu" | $ROFI \
  -p "Power" \
  -no-custom \
  -format 'i:s')

[ -z "$chosen" ] && exit

lockscreen_image=~/Pictures/Backgrounds/rebranding-alnixdev-v4.png
label=$(echo "$chosen" | cut -d: -f2-)
case "$label" in
*"Lock Screen"*)
  betterlockscreen -u "$lockscreen_image" && betterlockscreen -l &
  sleep 1 && xset dpms force off
  ;;
*"Log Out"*)
  i3-msg exit
  ;;
*"Restart"*)
  systemctl reboot
  ;;
*"Shut Down"*)
  systemctl poweroff
  ;;
*"Close"*)
  exit
  ;;
*"───"* | "")
  # Header or blank line selected — reopen menu
  exec "$0"
  ;;
esac
