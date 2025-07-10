WALLPAPER_PATH=$(grep '^wallpaper *= *' ~/.config/waypaper/config.ini | cut -d '=' -f2- | xargs)
WALLPAPER_PATH=${WALLPAPER_PATH/#\~/$HOME}
WAL_COLORS="$HOME/.cache/wal/colors.css"

# Update Rofi Thumbnail
ROFI_THUMB_PATH=$HOME/.config/rofi/thumbs/rofi-thumb.jpg

# Check file extension (case-insensitive)
EXT="${WALLPAPER_PATH##*.}"
EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')

if [[ "$EXT_LOWER" == "jpg" || "$EXT_LOWER" == "jpeg" ]]; then
  cp "$WALLPAPER_PATH" "$ROFI_THUMB_PATH"
else
  convert "$WALLPAPER_PATH[0]" "$ROFI_THUMB_PATH"
fi

magick "$ROFI_THUMB_PATH" -crop 500x1280+950+100 "$ROFI_THUMB_PATH"

# Update Rofi Colors
$HOME/.config/scripts/rofi-import-colors.sh
