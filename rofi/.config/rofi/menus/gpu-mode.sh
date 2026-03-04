#!/bin/bash
# ~/.config/rofi/menus/gpu-mode.sh
THEME="$HOME/.config/rofi/tokyonight.rasi"
ROFI="rofi -dmenu -i -theme $THEME"

current=$(supergfxctl --get 2>/dev/null || echo "unknown")

options=(
  "󰢮  Hybrid"
  "󰘚  Integrated"
  "󰅙  Close"
)

menu=$(printf '%s\n' "${options[@]}" | while read -r label; do
  mode=$(echo "$label" | awk '{print $NF}')
  if [ "$mode" = "$current" ]; then
    echo "$label  ◀ current"
  else
    echo "$label"
  fi
done)

chosen=$(echo "$menu" | $ROFI \
  -p "GPU Mode" \
  -no-custom \
  -format 'i:s')

[ -z "$chosen" ] && exit

echo "$chosen" | grep -q "Close" && exit

label=$(echo "$chosen" | grep -oP '(Integrated|Hybrid)')
supergfxctl --mode $label

notify-send -u critical -t 30000 \
  "󰍺 GPU Mode Changed" \
  "Switching to $label mode, the system will reboot in 15 seconds."

sleep 15
touch /tmp/reboot-on-logout
i3-msg exit
