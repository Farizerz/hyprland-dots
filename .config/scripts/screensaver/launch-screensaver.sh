#!/bin/bash

FLAG="$HOME/.cache/screensaver"
if [[ -f "$FLAG" ]]; then
  exit 0
fi

mkdir -p ~/.cache
touch "$FLAG"

ACTIVE_SCREENSAVER=~/.config/scripts/screensaver/pokemon.sh
ACTIVE_WORKSPACES=$(hyprctl monitors -j | jq '.[].activeWorkspace.id')
FOCUSED_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')

# Activate screensaver to monitor(s)
for i in $ACTIVE_WORKSPACES; do
  hyprctl dispatch exec "[workspace $i] alacritty --class Screensaver \
  --config-file ~/.config/alacritty/screensaver.toml \
  -e $ACTIVE_SCREENSAVER $FOCUSED_MONITOR"
done

sleep 0.5

LAST_CURSOR_POSITION=$(hyprctl cursorpos)

# Detect cursor movement
while true; do
  CURRENT_CURSOR_POSITION=$(hyprctl cursorpos)

  if [ "$LAST_CURSOR_POSITION" != "$CURRENT_CURSOR_POSITION" ]; then
    break
  fi
done

hyprctl dispatch focusmonitor $FOCUSED_MONITOR
pkill -f "alacritty --class Screensaver" 2>/dev/null
rm -rf ~/.cache/screensaver
exit 0

