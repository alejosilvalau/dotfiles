#!/bin/bash
# ~/.config/i3/lockscreen.sh

betterlockscreen -u ~/Pictures/Backgrounds/rebranding-alnixdev-v4.png

(sleep 1 && xset dpms force off && xset dpms 30 30 30) &

betterlockscreen -l

xset dpms 600 600 600
