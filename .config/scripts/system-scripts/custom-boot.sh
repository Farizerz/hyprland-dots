#!/bin/bash
# Change from regular boot (Exec=Hyprland) into custom boot using boot.sh

if grep -q "^Exec=Hyprland$" /usr/share/wayland-sessions/hyprland.desktop; then
    sudo sed -i "s|^Exec=Hyprland$|Exec=/home/$SUDO_USER/.config/scripts/system-scripts/boot.sh|" /usr/share/wayland-sessions/hyprland.desktop
fi
