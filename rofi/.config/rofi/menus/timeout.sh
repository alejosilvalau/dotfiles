#!/bin/bash
# ~/.config/rofi/menus/timeout.sh
THEME="$HOME/.config/rofi/tokyonight.rasi"
ROFI="rofi -dmenu -i -theme $THEME"

xset_q=$(xset q)
current=$(echo "$xset_q" | grep -oP 'Standby: \K\d+')
dpms=$(echo "$xset_q" | grep -oP 'DPMS is \K\w+')

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
  elif [[ "$label" == *"Disabled"* ]]; then
    [[ "$dpms" == "Disabled" ]] && echo "$label  ◀ current" || echo "$label"
  else
    # This part only runs for the timed options
    mins=$(echo "$label" | grep -oP '\d+')
    secs=$((${mins:-0} * 60))

    if [[ "$dpms" == "Enabled" && "$secs" -eq "$current" ]]; then
      echo "$label  ◀ current"
    else
      echo "$label"
    fi
  fi
done)

chosen=$(echo "$menu" | $ROFI \
  -p "Screen Timeout" \
  -no-custom \
  -format 's')

[[ -z "$chosen" || "$chosen" == *"Close"* ]] && exit

mins=$(echo "$chosen" | grep -oP '\d+')
secs=$((${mins:-0} * 60))

if [ $secs -eq 0 ]; then
  xset -dpms
else
  xset +dpms
  xset dpms $secs $secs $secs
fi

msg="${mins:+Screen will turn off in $mins minutes}"
notify-send "󰌾 Screen Timeout Changed" "${msg:-Timeout disabled}"
