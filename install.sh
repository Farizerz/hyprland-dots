echo "Installing packages..."
sleep 1
bash ~/.config/scripts/system/install-packages.sh
sleep 1
echo "Making scripts executable..."
sleep 1
bash ~/.config/scripts/scripts/system/execute-scripts.sh
sleep 1
echo "Enabling services..."
sleep 1
sudo ~/.config/scripts/system/enable-services.sh
sleep 1
echo "Done, restarting..."
sleep 2
reboot now