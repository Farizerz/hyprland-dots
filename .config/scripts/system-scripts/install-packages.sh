#!/bin/bash

# Packages to install
pacman=(
  hyprland
  sddm
  uwsm
  git base-devel
  waybar
  hyprpaper
  swww
  hyprlock
  alacritty
  ttf-jetbrains-mono-nerd
  networkmanager
  network-manager-applet
  bluez
  bluez-utils
  bc
  mpv
  thunar
  thunar-volman
  gvfs
  gvfs-mtp
  gvfs-gphoto2
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
  ffmpegthumbnailer
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
  easyeffects
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
  nano
  chromium
  cava
  obs-studio
  libreoffice-still
  yt-dlp
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
sudo chown -R "$SUDO_USER":"$SUDO_USER" $HOME/.local

sudo mv /usr/share/icons/Papirus /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Light ~/.local/share/icons/

# # Post-installation steps - Applying sddm theme
sudo cp -r /home/$SUDO_USER/.local/share/sddm/themes /usr/share/sddm

sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/virtualkbd.conf > /dev/null <<EOF
[General]
InputMethod=qtvirtualkeyboard
EOF

# Finished

echo "✅ Install finished."