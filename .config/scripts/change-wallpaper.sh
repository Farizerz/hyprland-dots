IMAGE_PATH="$1"

~/.config/scripts/switch-monitor.sh

# Change wallpaper
~/.config/scripts/theme/wallpaper.sh "$IMAGE_PATH"

# Change rofi theme
~/.config/scripts/theme/rofi.sh &

# Change dunst color
~/.config/scripts/theme/dunst.sh &

# Change cava color
~/.config/scripts/theme/cava.sh &

# Change folder color
~/.config/scripts/theme/papirus-folders-color.sh &

# Change vs code theme
~/.config/scripts/theme/code.sh &

# Generate logo
~/.config/scripts/theme/generate-logo.sh &

sleep 1.5
pkill thunar && thunar &
pkill waybar && waybar &
