IMAGE_PATH="$1"

~/.config/scripts/switch-monitor.sh 

# Change wallpaper
~/.config/scripts/theme-scripts/wallpaper.sh "$IMAGE_PATH"

# Change rofi theme
~/.config/scripts/theme-scripts/rofi.sh &

# Change dunst color
~/.config/scripts/theme-scripts/dunst.sh &

# Change cava color
~/.config/scripts/theme-scripts/cava.sh &

# Change folder color
~/.config/scripts/theme-scripts/papirus-folders-color.sh &

# Generate logo
~/.config/scripts/theme-scripts/generate-logo.sh &

sleep 1.5
pkill thunar && thunar &
pkill waybar && waybar