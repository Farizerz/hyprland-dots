#!/bin/bash

echo "Installing git..."
sleep 1
sudo pacman -Sy --noconfirm --needed git
sleep 1
echo "Removing old configs..."
sleep 1
rm -rf ~/*
rm -rf ~/.*
sleep 1
echo "Cloning into root..."
sleep 1
git clone -b main https://github.com/Farizerz/hyprland-dots.git ~/
sleep 1
bash ~/install.sh