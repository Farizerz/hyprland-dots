#!/bin/bash
# If internal monitor on initial boot is disabled, enable it

MONITOR_NAME="$($HOME/.config/scripts/system/get-monitors.sh name_internal)"
MONITOR_DETAILED="$($HOME/.config/scripts/system/get-monitors.sh detailed_internal)"
CONFIG="$HOME/.config/hypr/hyprconfig/monitors.conf"

if grep -q "^monitor=$MONITOR_NAME,disable" "$CONFIG"; then
  sed -i "s/^monitor=$MONITOR_NAME,disable/monitor=$MONITOR_DETAILED/" "$CONFIG"
fi

start-hyprland
