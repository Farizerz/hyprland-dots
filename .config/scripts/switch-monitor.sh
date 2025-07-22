#!/bin/bash

MONITORS=$(hyprctl monitors)
MONITOR_NAME="$($HOME/.config/scripts/system/get-monitors.sh name_internal)"
MONITOR_DETAILED="$($HOME/.config/scripts/system/get-monitors.sh detailed_internal)"
MONITOR_EXTERNAL_NAME="$($HOME/.config/scripts/system/get-monitors.sh name_external)"
CONFIG="$HOME/.config/hypr/hyprconfig/monitors.conf"
LID_STATE=$(cat /proc/acpi/button/lid/LID/state 2>/dev/null | grep -i 'closed')
OLD_MONITOR_DETAILS=$(grep "^monitor=$MONITOR_NAME," "$CONFIG")

if [[ $LID_STATE == *"closed"* ]]; then
  # Only replace if the line is NOT already disabled
  if grep -q "^monitor=$MONITOR_NAME," "$CONFIG" && ! grep -q "^monitor=$MONITOR_NAME,disable" "$CONFIG"; then
    sed -i "s/^monitor=$MONITOR_DETAILED/monitor=$MONITOR_NAME,disable/" "$CONFIG"
  fi
else
  # Only replace if internal monitor in monitor.conf is different from monitor-sources.conf
  if [[ "$OLD_MONITOR_DETAILS" != "monitor=$MONITOR_DETAILED" ]]; then
    sed -i "s/^monitor=$MONITOR_NAME,.*/monitor=$MONITOR_DETAILED/" "$CONFIG"
  fi
fi
