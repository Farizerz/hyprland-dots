#!/bin/bash

USERNAME=$1

# Packages to install
pacman=(
  # Core System / Utilities
  pacman-contrib
  parallel
  jq
  bc
  exa
  nano
  nvim
  smartmontools
  openssh
  ryzenadj
  # Display Server / Wayland / Hyprland Core
  xorg-server
  xorg-xinit
  hyprland
  hyprpaper
  hypridle
  sddm
  uwsm
  waybar
  swww
  hyprlock
  rofi-wayland
  rofi-emoji
  slurp
  grim
  swappy
  wl-clipboard
  qt5-wayland
  qt6-wayland
  qt6-svg
  qt6-virtualkeyboard
  qt6-multimedia-ffmpeg
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  xdg-user-dirs
  xdg-utils
  # Networking / Connectivity
  networkmanager
  bluez
  bluez-utils
  wpa_supplicant
  # Audio / Multimedia
  pipewire
  pipewire-alsa
  pipewire-pulse
  wireplumber
  pavucontrol
  easyeffects
  mpv
  ffmpeg
  ffmpegthumbnailer
  cava
  playerctl
  obs-studio
  yt-dlp
  chafa
  # File Management / System Tools
  thunar
  thunar-volman
  gvfs
  gvfs-mtp
  gvfs-gphoto2
  udisks2
  polkit
  polkit-kde-agent
  polkit-gnome
  ntfs-3g
  tumbler
  file-roller
  # Fonts / Themes / Appearance
  ttf-jetbrains-mono-nerd
  papirus-icon-theme
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  nwg-look
  nwg-displays
  brightnessctl
  fastfetch
  dunst
  # Applications / Productivity
  alacritty
  eog
  mousepad
  nvim
  chromium
  libreoffice-still
  android-tools
  scrcpy
  imagemagick
  btop
)

pacman_nvidia=(
  libva-nvidia-driver
  dkms
  nvidia-dkms
  nvidia-utils
  nvidia-settings
  egl-wayland
  opencl-nvidia
)

pacman_amd=(
  libva-mesa-driver
  mesa
  mesa-utils
  vulkan-radeon
  xf86-video-amdgpu
  xf86-video-ati
)

pacman_intel=(
  intel-media-driver
  libva-intel-driver
  vulkan-intel
)

pacman_vm=(
  mesa
)

while true; do
  echo "Select your GPU driver:"
  echo "1) Nvidia"
  echo "2) AMD"
  echo "3) Intel"
  echo "4) Virtual Machine"
  echo "5) Other (install all drivers)"
  read -rp "Enter choice [1-4]: " choice < /dev/tty

  case "$choice" in
    1) gpu_packages=("${pacman_nvidia[@]}"); break ;;
    2) gpu_packages=("${pacman_amd[@]}"); break ;;
    3) gpu_packages=("${pacman_intel[@]}"); break ;;
    4) gpu_packages=("${pacman_vm[@]}"); break ;;
    5) gpu_packages=("${pacman_intel[@]}" "${pacman_amd[@]}" "${pacman_nvidia[@]}"); break ;;
    *) echo "Invalid choice. Please enter 1, 2, 3, 4, or 5." ;;
  esac
done

all_pacman=("${pacman[@]}" "${gpu_packages[@]}")

# Install packages using pacman
sudo pacman -S --noconfirm --needed "${all_pacman[@]}"

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

# Post-installation steps - Applying sddm theme
sudo cp -r /home/$USERNAME/.local/share/sddm/themes /usr/share/sddm

sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/virtualkbd.conf > /dev/null <<EOF
[General]
InputMethod=qtvirtualkeyboard
EOF

# Post-installation steps - Detecting monitor sources
CONF="$HOME/.config/hypr/hyprconfig/monitor-sources.conf"

monitors=($(xrandr --query | grep " connected" | cut -d' ' -f1))

cat > "$CONF" <<'EOF'
# This is the source of anything related to laptop monitor scripts, you can (and should) change this according to your setup.
# The laptop monitor in monitors.conf will be replaced by these values everytime the pc boots, changing themes,
# or closing / opening laptop lid.

EOF

for mon in "${monitors[@]}"; do
    echo "monitor=$mon,preferred,auto,auto" >> "$CONF"
done

# Finished

echo "✅ Install finished."