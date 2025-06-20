### Change Random Wallpaper ###
  waypaper --random
  WALLPAPER_PATH=$(grep '^wallpaper *= *' ~/.config/waypaper/config.ini | cut -d '=' -f2- | xargs)
  WALLPAPER_PATH=${WALLPAPER_PATH/#\~/$HOME}
  wal -i "$WALLPAPER_PATH"

### Get colors ###
  WAL_COLORS="$HOME/.cache/wal/colors.css"

### Change Rofi ###

  # Update Rofi Thumbnail
  ROFI_THUMB_PATH=$HOME/.config/rofi/thumbs/rofi-thumb.jpg

  cp "$WALLPAPER_PATH" "$ROFI_THUMB_PATH"

  magick "$ROFI_THUMB_PATH" -crop 500x1280+950+200 "$ROFI_THUMB_PATH"

  # Update Rofi Colors
  $HOME/.config/scripts/rofi-import-colors.sh

### Restart Waybar ###
  pkill waybar && waybar &

### Change dunst color ###

  DUNST_CONFIG="$HOME/.config/dunst/dunstrc"

  # Extract background value from colors.css
  background=$(grep -Po -- '--background:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")
  foreground=$(grep -Po -- '--foreground:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")
  frame=$(grep -Po -- '--color13:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")
	folder=$(grep -Po -- '--color14:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")
  # Make sure color was found
  if [[ -z "$background" || -z "$foreground" || -z "$frame" ]]; then
      echo "color not found in $WAL_COLORS"
      exit 1
  fi

  # Replace background, foreground, and frame colors in dunstrc
  awk -v new_bg="$background" -v new_fg="$foreground" -v new_frame="$frame" '
    $0 ~ /^\[urgency_normal\]/ { in_section=1 }
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
  ' "$DUNST_CONFIG" > "$DUNST_CONFIG.tmp" && mv "$DUNST_CONFIG.tmp" "$DUNST_CONFIG"
  
  # Restart dunst to apply changes
  pkill dunst && dunst &

### Change folder colors ###

  ~/.config/scripts/change-icon-colors.sh "$folder"

### Change cava colors ###

  CAVA_CONFIG="$HOME/.config/cava/config"
  # Extract color from colors.css
  gradientColor1=$(grep -Po -- '--color13:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")
  gradientColor2=$(grep -Po -- '--color15:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")
  # Make sure color was found
  if [[ -z "$gradientColor1" || -z "$gradientColor2" ]]; then
      echo "color not found in $WAL_COLORS"
      exit 1
  fi

  # Replace color in cava config
  awk -v new_color1="$gradientColor1" -v new_color2="$gradientColor2" '
    $0 ~ /^\s*gradient_color_1\s*=/ {
        sub(/#[0-9a-fA-F]{6}/, new_color1)
    }
    /^\s*gradient_color_2\s*=/ {
        sub(/#[0-9a-fA-F]{6}/, new_color2)
    }
    { print }
  ' "$CAVA_CONFIG" > "$CAVA_CONFIG.tmp" && mv "$CAVA_CONFIG.tmp" "$CAVA_CONFIG"
