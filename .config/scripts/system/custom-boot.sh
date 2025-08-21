#!/bin/bash
# Change from regular boot (Exec=Hyprland) into custom boot using boot.sh

if grep -q "^Exec=Hyprland$" /usr/share/wayland-sessions/hyprland.desktop; then
    sudo sed -i "s|^Exec=Hyprland$|Exec=/home/$USER/.config/scripts/system/boot.sh|" /usr/share/wayland-sessions/hyprland.desktop
fi
