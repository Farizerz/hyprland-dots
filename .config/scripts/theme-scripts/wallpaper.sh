# Change to random wallpaper
waypaper --random

# Set wallpaper path
WALLPAPER_PATH=$(grep '^wallpaper *= *' ~/.config/waypaper/config.ini | cut -d '=' -f2- | xargs)
WALLPAPER_PATH=${WALLPAPER_PATH/#\~/$HOME}

# Change the color scheme using pywal
wal -i "$WALLPAPER_PATH"