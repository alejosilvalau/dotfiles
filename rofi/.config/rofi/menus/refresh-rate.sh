#!/bin/bash
# ~/.config/rofi/menus/refresh-rate.sh
THEME="$HOME/.config/rofi/tokyonight.rasi"
ROFI="rofi -dmenu -i -theme $THEME"

current=$(xrandr | grep -A1 "eDP connected" | grep '\*' | grep -oP '\d+(?=\.\d+\*)' | head -1)

options=(
  "󰍹  144 Hz"
  "󰍹  60 Hz"
  "󰅙  Close"
)

menu=$(printf '%s\n' "${options[@]}" | while read -r label; do
  rate=$(echo "$label" | grep -oP '\d+(?= Hz)')
  if [ "$rate" = "$current" ]; then
    echo "$label  ◀ current"
  else
    echo "$label"
  fi
done)

chosen=$(echo "$menu" | $ROFI \
  -p "Refresh Rate" \
  -no-custom \
  -format 'i:s')

[ -z "$chosen" ] && exit

echo "$chosen" | grep -q "Close" && exit

rate=$(echo "$chosen" | grep -oP '\d+(?= Hz)')

xrandr --output eDP --mode 1920x1080 --rate "$rate"
notify-send "󰍹 Refresh Rate Set To $rate Hz"
