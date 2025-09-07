#!/bin/bash

CONFIG_FILE=$HOME/.cache/.personalization.txt

DUNST=$HOME/.config/dunst/dunstrc
HYPRLAND_CONF=$HOME/.config/hypr/hyprconfig/style.conf
ROFI_DRUN=$HOME/.config/rofi/config.rasi
ROFI_EMOJI=$HOME/.config/rofi/themes/emoji.rasi
ROFI_WALLPAPER=$HOME/.config/rofi/themes/wallpaper.rasi
WLOGOUT=$HOME/.config/wlogout/style.css

RADIUS=10

OPTIONS="Default\nMinimal\nSquared\nSquared (Minimal)"
CURRENT_THEME=$(cat $CONFIG_FILE)

if [[ $CURRENT_THEME == 'minimal' ]]; then
  current="Minimal"
  select_index=1
elif [[ $CURRENT_THEME == 'squared' ]]; then
  current="Squared"
  select_index=2
elif [[ $CURRENT_THEME == 'squared-minimal' ]]; then
  current="Squared (Minimal)"
  select_index=3
else
  current="Default"
  select_index=0
fi

apply_border_radius() {
  # dunst
  sed -i "s/^\([[:space:]]*corner_radius = \)[0-9]\+/\1$RADIUS/" $DUNST

  # hyprland
  sed -i "s/^\([[:space:]]*rounding = \)[0-9]\+/\1$RADIUS/" $HYPRLAND_CONF

  # rofi
  sed -i "s/^\([[:space:]]*border-radius:[[:space:]]*\)[0-9]\+/\1$RADIUS/" $ROFI_DRUN
  sed -i "s/^\([[:space:]]*border-radius:[[:space:]]*\)[0-9]\+/\1$RADIUS/" $ROFI_EMOJI
  sed -i "s/^\([[:space:]]*border-radius:[[:space:]]*\)[0-9]\+/\1$RADIUS/" $ROFI_WALLPAPER

  # wlogout
  sed -i "s/^\([[:space:]]*border-radius:[[:space:]]*\)[0-9]\+/\1$RADIUS/" $WLOGOUT

  pkill dunst && dunst &
  pkill waybar && waybar &
}

chosen=$(echo -e "$OPTIONS" | rofi -dmenu -p "Select Visual Style " -selected-row $select_index)

case "$chosen" in
"Default")
  RADIUS=10
  apply_border_radius
  cp $HOME/.config/waybar/themes/default/* $HOME/.config/waybar/
  echo "default" >$CONFIG_FILE
  ;;
"Minimal")
  RADIUS=10
  apply_border_radius
  cp $HOME/.config/waybar/themes/minimal/* $HOME/.config/waybar/
  echo "minimal" >$CONFIG_FILE
  ;;
"Squared")
  RADIUS=0
  apply_border_radius
  cp $HOME/.config/waybar/themes/squared/* $HOME/.config/waybar/
  echo "squared" >$CONFIG_FILE
  ;;
"Squared (Minimal)")
  RADIUS=0
  apply_border_radius
  cp $HOME/.config/waybar/themes/squared-minimal/* $HOME/.config/waybar/
  echo "squared-minimal" >$CONFIG_FILE
  ;;
*)
  exit 1
  ;;
esac
