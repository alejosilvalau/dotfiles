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

target_mode=$(echo "$chosen" | grep -oP '(Integrated|Hybrid)')

# Don't trigger if the user selected the mode they are already on
[ "$target_mode" = "$current" ] && exit 0

# Apply the mode switch
supergfxctl --mode "$target_mode"

# Custom notifications based on transition direction
if [ "$current" = "Hybrid" ] && [ "$target_mode" = "Integrated" ]; then
  notify-send -u critical -t 15000 \
    "󰍺 GPU Mode Changed" \
    "Switched to Integrated mode, logging out in 15 seconds..."

elif [ "$current" = "Integrated" ] && [ "$target_mode" = "Hybrid" ]; then
  notify-send -u critical -t 15000 \
    "󰍺 GPU Mode Changed" \
    "Switched to Hybrid mode, logging out in 15 seconds...\n\n⚠️ Reboot recommended after log out."
else
  notify-send -u normal -t 15000 \
    "󰍺 GPU Mode Changed" \
    "Switching to $target_mode mode, logging out in 15 seconds..."
fi

sleep 15
i3-msg exit
