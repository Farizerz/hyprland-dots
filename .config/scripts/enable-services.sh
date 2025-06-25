sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now tlp
sudo systemctl enable --now sddm
sudo systemctl --user enable --now pipewire
sudo systemctl --user enable --now pipewire-pulse
sudo systemctl --user enable --now wireplumber

### For battery preset services ###

sudo EDITOR="tee -a" visudo <<EOF

$(whoami) ALL=(ALL) NOPASSWD: \\
/home/$(whoami)/.config/scripts/rofi-battery.sh, \\
/home/$(whoami)/.config/scripts/mount-drives.sh, \
/bin/mkdir, \
/usr/bin/mount, \
/usr/bin/umount, \
/bin/grep, \
/bin/cp, \
/usr/bin/tlp, \
/usr/bin/ryzenadj, \
/usr/bin/udisksctl
EOF

### Change hyprland boot service using custom script ###
sudo sed -i "s|^Exec=Hyprland$|Exec=/home/$(whoami)/.config/scripts/boot.sh|" /usr/share/wayland-sessions/hyprland.desktop

echo "✅ Services enabled and started."