#!/bin/bash
# ~/.config/rofi/menus/brightness.sh
# Uses brightnessctl for laptop screen only

THEME="$HOME/.config/rofi/tokyonight.rasi"

current=$(brightnessctl get)
max=$(brightnessctl max)
current_pct=$(((current * 100 / max + 2) / 5 * 5))

options=$(for v in $(seq 0 5 100); do
  if [ "$v" -eq "$current_pct" ]; then
    echo "󰃞  ${v}%  ◀ current"
  else
    echo "󰃞  ${v}%"
  fi
done)

options="$options
󰅙  Close"

chosen=$(echo "$options" | rofi -dmenu -i \
  -theme "$THEME" \
  -p "Brightness" \
  -no-custom)

[ -z "$chosen" ] && exit

echo "$chosen" | grep -q "Close" && exit

pct=$(echo "$chosen" | grep -oP '\d+(?=%)')
brightnessctl set "${pct}%"
