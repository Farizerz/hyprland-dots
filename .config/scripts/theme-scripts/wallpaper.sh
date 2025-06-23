# Change to random wallpaper
waypaper --random

# Set wallpaper path
WALLPAPER_PATH=$(grep '^wallpaper *= *' ~/.config/waypaper/config.ini | cut -d '=' -f2- | xargs)
WALLPAPER_PATH=${WALLPAPER_PATH/#\~/$HOME}

# Change lockscreen wallpaper
cp "$WALLPAPER_PATH" "$HOME/assets/lockscreens/lockscreen.jpg"

# Change the color scheme using pywal
wal -i "$WALLPAPER_PATH"

### Hyprland Colors ###

# Copy colors.scss to a temporary file
cp $HOME/.cache/wal/colors.scss $HOME/.cache/wal/tmp.conf

# Convert scss format to hyprland config format
sed -i '/^\$wallpaper *=/d' -e 's|// |# |g' -e 's|:| = |g' -e 's| #|rgba(|g' -e 's|;|ee)|g' $HOME/.cache/wal/tmp.conf

# Rename tmp to colors-hyprland.conf
mv $HOME/.cache/wal/tmp.conf $HOME/.cache/wal/colors-hyprland.conf

### Waybar & Wlogout Colors ###
cp $HOME/.cache/wal/colors-waybar.css $HOME/.config/waybar/colors.css

cp $HOME/.cache/wal/colors-waybar.css $HOME/.config/wlogout/colors.css
