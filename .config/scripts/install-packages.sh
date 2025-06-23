#!/bin/bash

# Packages to install
pacman=(
  hyprland
  sddm
  git base-devel
  waybar
  hyprpaper
  hyprlock
  alacritty
  ttf-jetbrains-mono-nerd
  networkmanager
  network-manager-applet
  bluez
  bluez-utils
  bc
  thunar
  thunar-volman
  gvfs
  udisks2
  polkit
  polkit-kde-agent
  polkit-gnome
  qt5-wayland
  qt6-wayland
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  xdg-user-dirs
  pacman-contrib
  parallel
  jq
  ntfs-3g
  tumbler
  rofi-wayland
  rofi-emoji
  fastfetch
  dunst
  btop
  pipewire
  pipewire-alsa
  pipewire-pulse
  wireplumber
  pavucontrol
  tlp
  slurp
  grim
  swappy
  wl-clipboard
  gwenview
  nwg-look
  nwg-displays
  file-roller
  mousepad
  papirus-icon-theme
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  swayidle
  brightnessctl
  playerctl
  imagemagick
  nvim
  chromium
  cava
)

# Install packages using pacman
sudo pacman -S --noconfirm --needed "${pacman[@]}"

yay=(
  wlogout
  papirus-folders
  ttf-ms-fonts
  tty-clock
  waypaper
  python-pywal
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

# Post-installation steps
sudo chown -R "$(whoami)":"$(whoami)" $HOME/.local/share/icons

sudo mv /usr/share/icons/Papirus /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Light ~/.local/share/icons/

echo "✅ Install finished."