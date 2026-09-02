#!/bin/bash
# ~/.config/i3/lockscreen.sh

notify-send -u normal -t 6000 "󰌾 Locking screen" "Screen will lock shortly..."

betterlockscreen -u ~/Pictures/Backgrounds/IMG_20250709_082307_edited.jpg

back_to_black=30
(sleep 1 && xset dpms force off && xset dpms $back_to_black $back_to_black $back_to_black) &

betterlockscreen -l blur

timeout=600
xset s $timeout $timeout
xset dpms $timeout $timeout $timeout
