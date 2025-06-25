#!/bin/bash

MONITOR_NAME="$($HOME/.config/scripts/get-monitors.sh name_internal)"
MONITOR_DETAILED="$($HOME/.config/scripts/get-monitors.sh detailed_internal)"
CONFIG="$HOME/.config/hypr/hyprconfig/monitors.conf"
LID_STATE=$(cat /proc/acpi/button/lid/LID/state 2>/dev/null | grep -i 'closed')


if [[ $LID_STATE == *"closed"* ]]; then
  # Only replace if the line is NOT already disabled
  if grep -q "^monitor=$MONITOR_NAME," "$CONFIG" && ! grep -q "^monitor=$MONITOR_NAME,disable" "$CONFIG"; then
    sed -i "s/^monitor=$MONITOR_DETAILED/monitor=$MONITOR_NAME,disable/" "$CONFIG"
  fi
else
  # Only replace if monitor is currently disabled
  if grep -q "^monitor=$MONITOR_NAME,disable" "$CONFIG"; then
    sed -i "s/^monitor=$MONITOR_NAME,disable/monitor=$MONITOR_DETAILED/" "$CONFIG"
  fi
fi