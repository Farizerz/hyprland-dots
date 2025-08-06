sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now tlp
sudo systemctl enable --now sddm

### For bypassing auth on battery preset services ###
echo "$SUDO_USER ALL=(ALL) NOPASSWD: /home/$SUDO_USER/.config/scripts/rofi-battery.sh, /bin/cp, /usr/bin/tlp" | sudo tee /etc/sudoers.d/rofi-battery > /dev/null

sudo chmod 0440 /etc/sudoers.d/rofi-battery

### For bypassing auth on custom boot & others ###
sudo EDITOR="tee -a" visudo <<EOF

$SUDO_USER ALL=(ALL) NOPASSWD: \\
/home/$SUDO_USER/.config/scripts/system/custom-boot.sh, \\
/usr/sbin/efibootmgr, \\
/usr/bin/ryzenadj
EOF

### Change hyprland boot service using custom script ###
sudo ~/.config/scripts/system/custom-boot.sh 

echo "✅ Services enabled and started."