#!/bin/bash

USERNAME=$(whoami)

# Packages to install
pacman=(
  hyprland
  sddm
  uwsm
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
  qt6-svg 
  qt6-virtualkeyboard 
  qt6-multimedia-ffmpeg
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  xdg-user-dirs
  xdg-utils
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
  chafa
  openssh
  smartmontools
  wget
  network-manager-applet
  wpa_supplicant
  exa
  android-tools
  scrcpy
  xorg-server
  xorg-xinit
  # intel graphics
  intel-media-driver
  libva-intel-driver
  vulkan-intel
  # AMD graphics
  libva-mesa-driver
  mesa
  vulkan-radeon
  xf86-video-amdgpu
  xf86-video-ati
  # Nvidia graphics
  libva-nvidia-driver
  dkms
  nvidia-dkms
  nvidia-utils
)

# Install packages using pacman
sudo pacman -S --noconfirm --needed "${pacman[@]}"

yay=(
  pinta
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
sudo mv /usr/share/icons/Papirus /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Light ~/.local/share/icons/

sudo chown -R "$USERNAME":"$USERNAME" $HOME/.local

# # Post-installation steps - Applying sddm theme
sudo cp -r /home/$USERNAME/.local/share/sddm/themes /usr/share/sddm

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