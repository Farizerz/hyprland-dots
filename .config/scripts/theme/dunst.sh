#!/bin/bash

DUNST_CONFIG="$HOME/.config/dunst/dunstrc"
WAL_COLORS="$HOME/.cache/wal/colors.css"

# Extract background value from colors.css
background=$(grep -Po -- '--background:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")
foreground=$(grep -Po -- '--foreground:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")
frame=$(grep -Po -- '--color14:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")

# Make sure color was found
if [[ -z "$background" || -z "$foreground" || -z "$frame" ]]; then
  echo "color not found in $WAL_COLORS"
  exit 1
fi

# Replace background, foreground, and frame colors in dunstrc
awk -v new_bg="$background" -v new_fg="$foreground" -v new_frame="$frame" '
  $0 ~ /^\[urgency_normal\]/ { in_section=1; }
  in_section && $0 ~ /^\s*background\s*=/ {
      sub(/#[0-9a-fA-F]{6}/, new_bg)
  }
  in_section && $0 ~ /^\s*foreground\s*=/ {
      sub(/#[0-9a-fA-F]{6}/, new_fg)
      in_section=0
  }
  /^\s*frame_color\s*=/ {
      sub(/#[0-9a-fA-F]{6,8}/, new_frame)
  }
  { print }
' "$DUNST_CONFIG" >"$DUNST_CONFIG.tmp" && sleep 0.1 && mv "$DUNST_CONFIG.tmp" "$DUNST_CONFIG"

# Restart dunst to apply changes
pkill dunst && dunst &
