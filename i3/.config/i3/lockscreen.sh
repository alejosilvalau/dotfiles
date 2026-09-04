#!/bin/bash
# ~/.config/i3/lockscreen.sh

notify-send -u normal -t 6000 "󰌾 Locking Screen" "Screen will lock shortly..."

betterlockscreen -u ~/Pictures/Backgrounds/IMG_20250709_082307_edited.jpg

saved_dpms_enabled=$(xset q 2>/dev/null | grep "DPMS is" | awk '{print $3}')
saved_timeout=$(xset q 2>/dev/null | grep "Standby:" | awk '{print $2}')
saved_timeout=${saved_timeout:-600}

back_to_black=30
(sleep 1 && xset dpms force off && xset dpms $back_to_black $back_to_black $back_to_black) &

betterlockscreen -l blur

if [ "$saved_dpms_enabled" = "Enabled" ]; then
  xset s $saved_timeout $saved_timeout
  xset dpms $saved_timeout $saved_timeout $saved_timeout
  # notify-send -u normal -t 4000 "󰌾 Screen Unlocked" "Screen timeout restored to $((saved_timeout / 60)) min"
else
  xset s off
  xset -dpms
  # notify-send -u normal -t 4000 "󰌾 Screen Unlocked" "Screen timeout has been disabled"
fi
