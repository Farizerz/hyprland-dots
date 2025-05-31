#/bin/sh

if [ -f "/usr/bin/swayidle" ]; then
  swayidle -w timeout 120 "hyprctl dispatch dpms off" resume "hyprctl dispatch dpms on"
else
  echo "swayidle is not found"
fi;