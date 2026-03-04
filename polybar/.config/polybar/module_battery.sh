#!/bin/bash
# ~/.config/polybar/battery.sh

status=$(cat /sys/class/power_supply/BAT0/status)
capacity=$(cat /sys/class/power_supply/BAT0/capacity)
energy_now=$(cat /sys/class/power_supply/BAT0/energy_now)
power_now=$(cat /sys/class/power_supply/BAT0/power_now)

# Battery level icon
if [ "$capacity" -le 10 ]; then
  icon="󰂎"
elif [ "$capacity" -le 20 ]; then
  icon="󰁺"
elif [ "$capacity" -le 30 ]; then
  icon="󰁻"
elif [ "$capacity" -le 40 ]; then
  icon="󰁼"
elif [ "$capacity" -le 50 ]; then
  icon="󰁽"
elif [ "$capacity" -le 60 ]; then
  icon="󰁾"
elif [ "$capacity" -le 70 ]; then
  icon="󰁿"
elif [ "$capacity" -le 80 ]; then
  icon="󰂀"
elif [ "$capacity" -le 90 ]; then
  icon="󰂁"
else
  icon="󰂂"
fi

# Calculate time remaining only if power_now is not zero
if [ "$power_now" -gt 0 ]; then
  time=$(echo "$energy_now $power_now" | awk '{
        h = int(($1/$2))
        m = int(($1/$2 - h) * 60)
        printf "%dh %02dm", h, m
    }')
else
  time="--"
fi

case "$status" in
Charging)
  energy_full=$(cat /sys/class/power_supply/BAT0/energy_full)
  time_full=$(echo "$energy_full $energy_now $power_now" | awk '{
            h = int(($1-$2)/$3)
            m = int((($1-$2)/$3 - h) * 60)
            printf "%dh %02dm", h, m
        }')
  echo "󰂄 ${capacity}% (${time_full})"
  ;;
Full)
  echo "󰁹 Full"
  ;;
"Not charging")
  echo "${icon} ${capacity}% (not charging)"
  ;;
Discharging)
  echo "${icon} ${capacity}% (${time})"
  ;;
esac
