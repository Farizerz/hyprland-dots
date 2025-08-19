#!/bin/bash

# For toggling internal monitors on / off if connected to external monitor

MONITOR_INTERNAL_NAME="$($HOME/.config/scripts/system/get-monitors.sh name_internal)"
MONITOR_INTERNAL_DETAILED="$($HOME/.config/scripts/system/get-monitors.sh detailed_internal)"
MONITOR_EXTERNAL_NAME="$($HOME/.config/scripts/system/get-monitors.sh name_external)"
MONITORS=$(hyprctl monitors)

if echo "$MONITORS" | grep -q "^Monitor $MONITOR_INTERNAL_NAME" && echo "$MONITORS" | grep -q "^Monitor $MONITOR_EXTERNAL_NAME"; then
  hyprctl keyword monitor "$MONITOR_INTERNAL_NAME,disable"
else
  hyprctl keyword monitor "$MONITOR_INTERNAL_DETAILED"
fi