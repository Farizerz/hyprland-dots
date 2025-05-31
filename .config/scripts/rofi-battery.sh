#!/bin/bash

options="Full Capacity (100%)\nBalanced (80%)\nMaximum Lifespan (60%)"

if sudo grep -q '# preset: full-capacity' /etc/tlp.conf; then
  current="Full Capacity (100%)"
  select_index=0
elif sudo grep -q '# preset: balanced' /etc/tlp.conf; then
  current="Balanced (80%)"
  select_index=1
elif sudo grep -q '# preset: maximum-lifespan' /etc/tlp.conf; then
  current="Maximum Lifespan (60%)"
  select_index=2
else
  current=""
  select_index=0
fi

chosen=$(echo -e "$options" | rofi -dmenu -p "Select Battery Preset: " -selected-row $select_index)

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
