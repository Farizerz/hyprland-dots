#!/bin/bash

INTERVAL=10
LAST_FOCUSED_MONITOR=$1

stty -icanon -echo

while true; do
  cols=$(tput cols)
  lines=$(tput lines)

  # Random horizontal position
  choice=$((RANDOM % 3))
  case $choice in
  0) pad=0 ;;              # left
  1) pad=$((cols / 2)) ;;  # center
  2) pad=$((cols - 50)) ;; # right
  esac
  [ $pad -lt 0 ] && pad=0

  # Random vertical position
  row=$((RANDOM % (lines - 20) + 1))

  clear
  printf "\033[%d;1H" "$row"

  while IFS= read -r line; do
    printf "%*s%s\n" "$pad" "" "$line"
  done <<<$(pokemon-colorscripts -r)

  if read -t $INTERVAL -n 1 key; then
    hyprctl dispatch focusmonitor $LAST_FOCUSED_MONITOR
    pkill -f "alacritty --class Screensaver" 2>/dev/null
    stty icanon echo
    rm -rf ~/.cache/.screensaver
    exit 0
  fi
done
