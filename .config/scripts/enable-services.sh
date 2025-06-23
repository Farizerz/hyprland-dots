sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now tlp
sudo systemctl enable --now sddm
sudo systemctl --user enable --now pipewire
sudo systemctl --user enable --now pipewire-pulse
sudo systemctl --user enable --now wireplumber

echo "✅ Services enabled and started."