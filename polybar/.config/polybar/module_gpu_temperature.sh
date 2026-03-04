#!/bin/bash
# ~/.config/polybar/gpu-temp.sh

mode=$(supergfxctl --get 2>/dev/null)

case "$mode" in
Dedicated | Hybrid)
  # dGPU via nvidia-smi
  temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)
  [ -n "$temp" ] && echo "dGPU ${temp}°C" || echo ""
  ;;
Integrated)
  # iGPU via hwmon — find the AMD/Intel GPU hwmon
  hwmon=$(grep -l "amdgpu\|i915" /sys/class/hwmon/*/name 2>/dev/null | head -1 | xargs dirname)
  if [ -n "$hwmon" ]; then
    temp=$(cat "${hwmon}/temp1_input" 2>/dev/null)
    [ -n "$temp" ] && echo "iGPU $((temp / 1000))°C" || echo ""
  fi
  ;;
*)
  echo ""
  ;;
esac
