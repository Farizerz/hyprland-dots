echo "Installing packages..."
sleep 1
bash ~/.config/scripts/install-packages.sh
sleep 1
echo "Making scripts executable..."
sleep 1
bash ~/.config/scripts/execute-scripts.sh
sleep 1
echo "Enabling services..."
sleep 1
sudo ~/.config/scripts/enable-services.sh
sleep 1
echo "Done."