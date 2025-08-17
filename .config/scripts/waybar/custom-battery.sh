#!/bin/bash

BAT=$(grep -l "Battery" /sys/class/power_supply/*/type | grep -o '/sys/class/power_supply/BAT[0-9]*')
AC=$(grep -l "Mains" /sys/class/power_supply/*/type | sed 's|/type||')

[[ ! -e "$BAT" ]] && echo "{\"text\": \"\", \"tooltip\": \"AC POWER\", \"class\": \"nobattery\"}" && exit

STATUS=$(<"$BAT/status")
AC_POWER=$(<"$AC/online")
CAPACITY=$(<"$BAT/capacity")
UPTIME=$(uptime -p | sed -E 's/up //; s/ hours?/ h/; s/ minutes?/ min/; s/,//g')
ENERGY_NOW=""
ENERGY_FULL=""
POWER_NOW=""

# Detect file type (energy or charge)
if [[ -f "$BAT/energy_now" ]]; then
    ENERGY_NOW=$(cat "$BAT/energy_now")
    ENERGY_FULL=$(cat "$BAT/energy_full")
    POWER_NOW=$(cat "$BAT/power_now")
elif [[ -f "$BAT/charge_now" ]]; then
    ENERGY_NOW=$(cat "$BAT/charge_now")
    ENERGY_FULL=$(cat "$BAT/charge_full")
    POWER_NOW=$(cat "$BAT/current_now")
else
    echo "{\"text\": \"N/A\", \"class\": \"nobattery\"}" && exit
fi

# Prevent division by zero
if [[ "$POWER_NOW" -gt 0 ]]; then
  if [[ "$STATUS" == "Charging" ]]; then
    REMAIN_ENERGY=$((ENERGY_FULL - ENERGY_NOW))
    TIME_HOURS=$(awk "BEGIN { printf \"%.2f\", $REMAIN_ENERGY / $POWER_NOW }")
  else
    TIME_HOURS=$(awk "BEGIN { printf \"%.2f\", $ENERGY_NOW / $POWER_NOW }")
  fi

  TIME_H=$(awk "BEGIN { print int($TIME_HOURS) }")
  TIME_M=$(awk "BEGIN { print int(($TIME_HOURS - $TIME_H) * 60) }")
  TIME_REMAINING="$(if [ "$STATUS" == "Charging" ]; then echo 'Time to full'; else echo 'Time to empty'; fi): ${TIME_H} h ${TIME_M} min"
else
  TIME_REMAINING="$(if [ "$AC_POWER" == "1" ]; then echo 'Plugged'; else echo 'N/A'; fi)"
fi

BAT_ICON="$(if [ "$AC_POWER" == "1" ]; then echo ''; else echo '󰁹'; fi)"

# Change Icons based on Percentage
ICON=""
ICON_LEVEL=$((CAPACITY / 10))
case $ICON_LEVEL in
  0) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  1) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  2) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  3) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  4) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  5) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  6) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  7) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  8) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  9) ICON="<span><span font='11'>$BAT_ICON</span> </span>" ;;
  10) ICON="<span><span font='11'>$BAT_ICON</span>  </span>" ;;
esac

# Decide text and class
if [[ "$STATUS" == "Charging" ]]; then
  TEXT="<span><span font='11'>$BAT_ICON</span> <span color='#FFD700' font='11'>󱐋</span></span>"
  CLASS="charging"
elif [[ "$CAPACITY" -le 15 ]]; then
  TEXT=$ICON
  CLASS="critical"
elif [[ "$CAPACITY" -le 29 ]]; then
  TEXT=$ICON
  CLASS="low"
elif [[ "$CAPACITY" -le 50 ]]; then
  TEXT=$ICON
  CLASS="warning"
elif [[ "$CAPACITY" -ge 98 ]]; then
  TEXT=$ICON
  CLASS="full"
else
  TEXT=$ICON
  CLASS=""
fi

TOOLTIP="Uptime: $UPTIME\\n$TIME_REMAINING" 

# Output JSON
echo "{\"text\": \"$TEXT\", \"percentage\": $CAPACITY, \"tooltip\": \"$TOOLTIP\", \"class\": \"$CLASS\"}"
