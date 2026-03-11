#!/bin/bash
# ~/.config/rofi/menus/timeout.sh
THEME="$HOME/.config/rofi/tokyonight.rasi"
ROFI="rofi -dmenu -i -theme $THEME"

current=$(xset q | grep -oP 'Standby: \K\d+')

options=(
  "󰌾  10 minutes"
  "󰌾  6 minutes"
  "󰌾  3 minutes"
  "  Disabled"
  "󰅙  Close"
)

menu=$(printf '%s\n' "${options[@]}" | while read -r label; do
  if [[ "$label" == *"Close"* ]]; then
    echo "$label"
    continue
  fi

  mins=$(echo "$label" | grep -oP '\d+')
  secs=$((${mins:-0} * 60))

  if [ $secs -eq $current ]; then
    echo "$label  ◀ current"
  else
    echo "$label"
  fi
done)

chosen=$(echo "$menu" | $ROFI \
  -p "Screen Timeout" \
  -no-custom \
  -format 's')

[[ -z "$chosen" || "$chosen" == *"Close"* ]] && exit

mins=$(echo "$chosen" | grep -oP '\d+')
secs=$((${mins:-0} * 60))

xset dpms "$secs" "$secs" "$secs"

msg="${mins:+Screen will turn off in $mins minutes}"
notify-send "󰌾 Screen Timeout Changed" "${msg:-Timeout has been disabled}"
