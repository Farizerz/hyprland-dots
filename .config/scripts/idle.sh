#/bin/sh

# Deprecated, now using hypridle

if [ -f "/usr/bin/swayidle" ]; then
  swayidle -w \
  timeout 180 "playerctl status | grep -q Playing || hyprctl dispatch dpms off" resume "hyprctl dispatch dpms on" \
  timeout 600 "[ '$(cat /sys/class/power_supply/AC0/online) -eq 0 ] && systemctl suspend"
else
  echo "swayidle is not found";
fi;