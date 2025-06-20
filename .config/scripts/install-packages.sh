#!/bin/bash

# Packages to install
pacman=(
  hyprland
  git base-devel
  waybar
  hyprpaper
  alacritty
  ttf-jetbrains-mono-nerd
  networkmanager
  bluez
  bluez-utils
  bc
  thunar
  thunar-volman
  gvfs
  udisks2
  polkit
  polkit-gnome
  ntfs-3g
  tumbler
  rofi-wayland
  rofi-emoji
  fastfetch
  dunst
  btop
  pipewire
  pavucontrol
  tlp
  slurp
  grim
  wl-clipboard
  gwenview
  nwg-look
  file-roller
  mousepad
  papirus-icon-theme
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  swayidle
  brightnessctl
  imagemagick
  nvim
  chromium
  cava
  libreoffice-still
)

# Install packages using pacman
sudo pacman -S --noconfirm --needed "${pacman[@]}"

yay=(
  wlogout
  papirus-folders
  tty-clock
  waypaper
  python-pywal16
  swaylock-effects
  pokemon-colorscripts-git
  visual-studio-code-bin
)

# Check if yay is installed
if ! command -v yay &> /dev/null; then
  echo "yay not found. Installing yay..."

  # Clone yay AUR repo
  tmp_dir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
  cd "$tmp_dir/yay" || exit 1

  # Build and install yay
  makepkg -si --noconfirm

  # Clean up
  cd ~
  rm -rf "$tmp_dir"

  echo "yay installed successfully."
else
  echo "yay is already installed."
fi

# Install packages from AUR using yay
yay -S --noconfirm --needed "${yay[@]}"

sudo chown -R "$(whoami)":"$(whoami)" $HOME/.local/share/icons

sudo mv /usr/share/icons/Papirus /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Light ~/.local/share/icons/

echo "✅ All packages installed successfully."