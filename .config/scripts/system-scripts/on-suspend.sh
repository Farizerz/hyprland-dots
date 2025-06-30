#!/bin/bash

LID_STATE=$(awk '{print tolower($NF)}' /proc/acpi/button/lid/LID/state 2>/dev/null)
DETAILED_INTERNAL="$($HOME/.config/scripts/system-scripts/get-monitors.sh detailed_internal)"
monitors=$(hyprctl monitors)

if [[ "$LID_STATE" == "closed" ]]; then
  systemctl suspend
else
  hyprctl keyword monitor "$DETAILED_INTERNAL"
fi

hyprlock