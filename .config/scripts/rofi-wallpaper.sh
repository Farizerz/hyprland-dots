#!/bin/bash

# Show a Rofi menu with icons and get the selected filename
SELECTED=$(ls ~/.local/share/assets/wallpapers/ | while read -r A; do
  echo -en " $A\x00icon\x1f~/.local/share/assets/wallpapers/$A\n"
done | rofi -dmenu -show-icons -p "Select Wallpaper ")

# If nothing is selected, exit
[ -z "$SELECTED" ] && exit

# Trim leading space
SELECTED_CLEAN=$(echo "$SELECTED" | sed 's/^ *//')

# Full path to the selected image
FULL_PATH="$HOME/.local/share/assets/wallpapers/$SELECTED_CLEAN"

# Output full path
~/.config/scripts/change-wallpaper.sh "$FULL_PATH"