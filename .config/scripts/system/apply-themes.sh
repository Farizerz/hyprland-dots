#!/bin/bash

gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
sleep 1
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
sleep 1
wal -i "$HOME/.local/share/assets/wallpapers/wallpaper01.jpg"