#!/bin/bash

LID_STATE=$(cat /proc/acpi/button/lid/LID/state 2>/dev/null | grep -i 'closed')

if [[ $LID_STATE == *"closed"* ]]; then
  hyprctl keyword monitor "eDP-1,disable"
else
  hyprctl keyword monitor "eDP-1,2880x1620@120,auto,1.5"
fi