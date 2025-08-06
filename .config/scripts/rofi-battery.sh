#!/bin/bash

BAT=$(grep -l "Battery" /sys/class/power_supply/*/type | sed 's|/type||')
THRESHOLD_FILE="$BAT/charge_control_end_threshold"

if [[ ! -f "$THRESHOLD_FILE" ]]; then
  echo "❌ Battery threshold control not supported on this device."
  exit 1
fi

OPTIONS="Full Capacity (100%)\nBalanced (80%)\nMaximum Lifespan (60%)"
CURRENT_THRESHOLD=$(cat $THRESHOLD_FILE)

if [[ $CURRENT_THRESHOLD == 100 ]]; then
  current="Full Capacity (100%)"
  select_index=0
elif [[ $CURRENT_THRESHOLD == 80 ]]; then
  current="Balanced (80%)"
  select_index=1
elif [[ $CURRENT_THRESHOLD == 60 ]]; then
  current="Maximum Lifespan (60%)"
  select_index=2
else
  current=""
  select_index=0
fi


chosen=$(echo -e "$OPTIONS" | rofi -dmenu -p "Select Battery Preset " -selected-row $select_index)

case "$chosen" in
  "Full Capacity (100%)")
    sudo cp $HOME/.config/scripts/battery-presets/full-capacity.txt /etc/tlp.conf
    sudo tlp start
    ;;
  "Balanced (80%)")
    sudo cp $HOME/.config/scripts/battery-presets/balanced.txt /etc/tlp.conf
    sudo tlp start
    ;;
  "Maximum Lifespan (60%)")
    sudo cp $HOME/.config/scripts/battery-presets/maximum-lifespan.txt /etc/tlp.conf
    sudo tlp start
    ;;
  *)
    exit 1
    ;;
esac