#!/bin/bash

LAST_FOCUSED_MONITOR=$1

stty -icanon -echo

clear
read -n 1 key
hyprctl dispatch focusmonitor $LAST_FOCUSED_MONITOR
pkill -f "alacritty --class Screensaver" 2>/dev/null
stty icanon echo
rm -rf ~/.cache/.screensaver

exit 0
