pkill waybar

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

sleep 0.5
~/.config/scripts/switch-monitor.sh

waybar
