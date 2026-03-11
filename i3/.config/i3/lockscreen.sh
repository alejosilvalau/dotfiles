#!/bin/bash
# ~/.config/i3/lockscreen.sh

betterlockscreen -u ~/Pictures/Backgrounds/rebranding-alnixdev-v4.png

back_to_black=30
(sleep 1 && xset dpms force off && xset dpms $back_to_black $back_to_black $back_to_black) &

betterlockscreen -l

timeout=600
xset s $timeout $timeout
xset dpms $timeout $timeout $timeout
