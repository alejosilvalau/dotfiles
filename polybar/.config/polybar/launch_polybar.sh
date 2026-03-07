#!/bin/bash
killall -q polybar
while pgrep -u $UID -x polybar; do sleep 1; done

polybar toph-primary &

for m in $(polybar --list-monitors | grep -v "eDP" | cut -d":" -f1); do
  MONITOR=$m polybar toph-secondary &
done
