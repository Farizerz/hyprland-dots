#!/bin/bash
# Change from regular boot (Exec=Hyprland) into custom boot using boot.sh

if grep -q "^Exec=start-hyprland$" /usr/share/wayland-sessions/hyprland.desktop; then
  sudo sed -i "s|^Exec=start-hyprland$|Exec=/home/$SUDO_USER/.config/scripts/system/boot.sh|" /usr/share/wayland-sessions/hyprland.desktop
fi
