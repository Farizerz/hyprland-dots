#!/bin/bash

IMAGE_PATH="$1"

if [[ -n "$IMAGE_PATH" ]]; then
  # If path is not empty
  waypaper --wallpaper "$IMAGE_PATH"
else
  # If no path is given, set a random wallpaper
  waypaper --random
fi

# Set wallpaper path
WALLPAPER_PATH=$(grep '^wallpaper *= *' ~/.config/waypaper/config.ini | cut -d '=' -f2- | xargs)
WALLPAPER_PATH=${WALLPAPER_PATH/#\~/$HOME}

# Change lockscreen to selected wallpaper
TARGET="$HOME/.local/share/assets/lockscreens/lockscreen.jpg"

# Check file extension (case-insensitive)
EXT="${WALLPAPER_PATH##*.}"
EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')

if [[ "$EXT_LOWER" == "jpg" || "$EXT_LOWER" == "jpeg" ]]; then
  cp "$WALLPAPER_PATH" "$TARGET"
else
  convert "$WALLPAPER_PATH[0]" "$TARGET"
fi

# Change the color scheme using pywal
wal -i "$WALLPAPER_PATH"

### Hyprland Colors ###

# Copy colors.scss to a temporary file
cp $HOME/.cache/wal/colors.scss $HOME/.cache/wal/tmp.conf

# Convert scss format to hyprland config format
sed -i '/^\$wallpaper *=/d' -e 's|// |# |g' -e 's|:| = |g' -e 's| #|rgba(|g' -e 's|;|ee)|g' $HOME/.cache/wal/tmp.conf

# Rename tmp to colors-hyprland.conf
mv $HOME/.cache/wal/tmp.conf $HOME/.cache/wal/colors-hyprland.conf

### Import css colors ###
mkdir $HOME/.config/colors/
cp $HOME/.cache/wal/colors-waybar.css $HOME/.config/colors/colors.css

### Alacritty colors ###
INPUT_FILE=$HOME/.cache/wal/colors-kitty.conf
OUTPUT_FILE=$HOME/.cache/wal/colors-alacritty.toml

# Read all key-value pairs from alacritty config
declare -A colors
while read -r key value; do
  [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue
  colors[$key]=$value
done <"$INPUT_FILE"

# Write to alacritty.toml
cat <<EOF >"$OUTPUT_FILE"
[colors.primary]
foreground = "${colors[foreground]}"
background = "${colors[background]}"

[colors.normal]
black   = "${colors[color0]}"
red     = "${colors[color1]}"
green   = "${colors[color2]}"
yellow  = "${colors[color3]}"
blue    = "${colors[color4]}"
magenta = "${colors[color5]}"
cyan    = "${colors[color6]}"
white   = "${colors[color7]}"

[colors.bright]
black   = "${colors[color8]}"
red     = "${colors[color9]}"
green   = "${colors[color10]}"
yellow  = "${colors[color11]}"
blue    = "${colors[color12]}"
magenta = "${colors[color13]}"
cyan    = "${colors[color14]}"
white   = "${colors[color15]}"
EOF

echo "✅ Converted to $OUTPUT_FILE"
