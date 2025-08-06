sudo -v
while true; do sudo -n true; sleep 60; done 2>/dev/null &

echo "Installing packages..."
sleep 1
bash /home/$USER/.config/scripts/system/install-packages.sh
sleep 1
echo "Making scripts executable..."
sleep 1
bash /home/$USER/.config/scripts/system/execute-scripts.sh
sleep 1
echo "Enabling services..."
sleep 1
sudo bash /home/$USER/.config/scripts/system/enable-services.sh
sleep 1
echo "Done, restarting..."
sleep 2
reboot now