sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now tlp
sudo systemctl enable --now sddm
sudo systemctl --user enable --now pipewire
sudo systemctl --user enable --now pipewire-pulse
sudo systemctl --user enable --now wireplumber

### For bypassing auth on battery preset services ###
echo "$SUDO_USER ALL=(ALL) NOPASSWD: /home/$SUDO_USER/.config/scripts/rofi-battery.sh, /bin/cp, /usr/bin/tlp" | sudo tee /etc/sudoers.d/rofi-battery > /dev/null

sudo chmod 0440 /etc/sudoers.d/rofi-battery

### For bypassing auth on custom boot & ryzenadj ###
sudo EDITOR="tee -a" visudo <<EOF

$SUDO_USER ALL=(ALL) NOPASSWD: \\
/home/$SUDO_USER/.config/scripts/system-scripts/custom-boot.sh
EOF

### Change hyprland boot service using custom script ###
sudo ~/.config/scripts/system-scripts/custom-boot.sh 

echo "✅ Services enabled and started."