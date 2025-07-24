~/.config/scripts/switch-monitor.sh

# Change Random Wallpaper
~/.config/scripts/theme/wallpaper.sh

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

sleep 0.5

hyprctl dispatch workspace 2

waybar &

sleep 1

ffplay -nodisp -autoexit -volume 50 ~/assets/audio/startup.mp3 &