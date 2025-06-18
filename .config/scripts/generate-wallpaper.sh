waypaper --random
WALLPAPER_PATH=$(grep '^wallpaper *= *' ~/.config/waypaper/config.ini | cut -d '=' -f2- | xargs)
WALLPAPER_PATH=${WALLPAPER_PATH/#\~/$HOME}
wal -i "$WALLPAPER_PATH"

# change rofi thumbs
ROFI_THUMB_PATH=$HOME/.config/rofi/thumbs/rofi-thumb.jpg

# Symlink (or copy) to a known path used by rofi
cp "$WALLPAPER_PATH" "$ROFI_THUMB_PATH"

magick "$ROFI_THUMB_PATH" -crop 300x1080+950+500 "$ROFI_THUMB_PATH"
