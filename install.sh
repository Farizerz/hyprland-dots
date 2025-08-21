#!/bin/bash

echo "Installing packages..."
sleep 1
bash /home/$USER/.config/scripts/system/install-packages.sh $USER
sleep 1
echo "Making scripts executable..."
sleep 1
bash /home/$USER/.config/scripts/system/execute-scripts.sh
sleep 1
echo "Enabling services..."
sleep 1
bash /home/$USER/.config/scripts/system/enable-services.sh $USER
sleep 1
echo "Removing 1-time auth bypass..."
sleep 1
sudo rm /etc/sudoers.d/bypass-auth
sleep 1
echo "Done, restarting..."
sleep 2
reboot