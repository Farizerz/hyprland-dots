#!/bin/bash

sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now tlp
sudo systemctl enable --now sddm

USERNAME=$1

### For bypassing auth on battery preset services ###
echo "$USERNAME ALL=(ALL) NOPASSWD: /home/$USERNAME/.config/scripts/rofi-battery.sh, /bin/cp, /usr/bin/tlp" | sudo tee /etc/sudoers.d/rofi-battery > /dev/null

sudo chmod 0440 /etc/sudoers.d/rofi-battery

### For bypassing auth on custom boot & others ###
sudo EDITOR="tee -a" visudo <<EOF

$USERNAME ALL=(ALL) NOPASSWD: \\
/home/$USERNAME/.config/scripts/system/custom-boot.sh, \\
/usr/sbin/efibootmgr
EOF

### For virtual camera on OBS ###
sudo modprobe v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera"

### Change hyprland boot service using custom script ###
sudo ~/.config/scripts/system/custom-boot.sh 

echo "✅ Services enabled and started."