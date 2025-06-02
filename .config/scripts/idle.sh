#/bin/sh

if [ -f "/usr/bin/swayidle" ]; then
  swayidle -w \
  timeout 120 "hyprctl dispatch dpms off" resume "hyprctl dispatch dpms on" \
  timeout 600 "[ '$(cat /sys/class/power_supply/AC0/online) -eq 0 ] && systemctl suspend"
else
  echo "swayidle is not found";
fi;