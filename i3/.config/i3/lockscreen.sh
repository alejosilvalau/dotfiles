#!/bin/bash
# ~/.config/i3/lockscreen.sh

notify-send -u normal -t 6000 "󰌾 Locking Screen" "Screen will lock shortly..."

betterlockscreen -u ~/Pictures/Backgrounds/IMG_20250709_082307_edited.jpg

saved_timeout=$(xset q 2>/dev/null | grep "Standby:" | awk '{print $2}')
saved_timeout=${saved_timeout:-600}

back_to_black=30
(sleep 1 && xset dpms force off && xset dpms $back_to_black $back_to_black $back_to_black) &

betterlockscreen -l blur

timeout=$saved_timeout
xset s $timeout $timeout
xset dpms $timeout $timeout $timeout

notify-send -u normal -t 4000 "󰌾 Screen Unlocked" "Screen timeout restored to $((timeout / 60)) min"
