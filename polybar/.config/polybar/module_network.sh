#!/bin/bash
# ~/.config/polybar/module_network.sh

eth=$(ip link show | awk -F": " "/^[0-9]+: e/{print \$2}" | head -1)
wifi=$(ip link show | awk -F": " "/^[0-9]+: w/{print \$2}" | head -1)

if [ -n "$eth" ] && cat /sys/class/net/${eth}/operstate 2>/dev/null | grep -q up; then
  echo "󰈀"
elif [ -n "$wifi" ] && cat /sys/class/net/${wifi}/operstate 2>/dev/null | grep -q up; then
  echo "󰤨"
else
  echo "󰤭"
fi
