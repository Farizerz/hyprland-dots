#!/bin/bash

sudo -v

# Keep sudo alive until script ends
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID' EXIT

# 1-time bypass authentication for installation purposes (will be removed after installation finishes)
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/makepkg, /usr/bin/yay, /usr/bin/pacman" | sudo tee /etc/sudoers.d/bypass-auth
sudo chmod 440 /etc/sudoers.d/bypass-auth

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