~/.config/scripts/switch-monitor.sh

# Change Random Wallpaper
~/.config/scripts/theme-scripts/wallpaper.sh

# Change rofi theme
~/.config/scripts/theme-scripts/rofi.sh &

# Change dunst color
~/.config/scripts/theme-scripts/dunst.sh &

# Change cava color
~/.config/scripts/theme-scripts/cava.sh &

# Change folder color
~/.config/scripts/theme-scripts/papirus-folders-color.sh &

# Change vs code theme
~/.config/scripts/theme-scripts/code.sh &

# Generate logo
~/.config/scripts/theme-scripts/generate-logo.sh &

sleep 0.5

hyprctl dispatch workspace 2

waybar
