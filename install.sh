echo "Installing packages..."
sleep 1
bash ~/.config/scripts/system-scripts/install-packages.sh
sleep 1
echo "Making scripts executable..."
sleep 1
bash ~/.config/scripts/system-scripts/execute-scripts.sh
sleep 1
echo "Enabling services..."
sleep 1
sudo ~/.config/scripts/system-scripts/enable-services.sh
sleep 1
echo "Done."