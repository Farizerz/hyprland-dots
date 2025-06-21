WALLPAPER_PATH=$(grep '^wallpaper *= *' ~/.config/waypaper/config.ini | cut -d '=' -f2- | xargs)
WALLPAPER_PATH=${WALLPAPER_PATH/#\~/$HOME}
WAL_COLORS="$HOME/.cache/wal/colors.css"

# Update Rofi Thumbnail
ROFI_THUMB_PATH=$HOME/.config/rofi/thumbs/rofi-thumb.jpg

cp "$WALLPAPER_PATH" "$ROFI_THUMB_PATH"

magick "$ROFI_THUMB_PATH" -crop 500x1280+950+200 "$ROFI_THUMB_PATH"

# Update Rofi Colors
  $HOME/.config/scripts/rofi-import-colors.sh
