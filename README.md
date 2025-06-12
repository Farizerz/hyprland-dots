# Hyprland Fariz Theme

![image](https://github.com/user-attachments/assets/f8f27dea-39aa-4f0f-8d14-a82987eee240)

![image](https://github.com/user-attachments/assets/568f8a2c-9a19-48e8-a497-078777ce86a1)

![image](https://github.com/user-attachments/assets/485de9db-c55a-48d6-a1d7-fdf33cb82bca)

## Requirements

Here are the list of the package required to install from pacman

- waybar
- hyprpaper
- alacritty
- ttf-jetbrains-mono-nerd
- networkmanager
- bluez bluez-utils
- thunar thunar-volman gvfs udisks2 polkit polkit-gnome ntfs-3g tumbler
- rofi-wayland
- rofi-emoji
- fastfetch
- dunst
- btop
- pipewire
- pavucontrol
- tlp
- slurp
- grim
- gwenview
- nwg-look
- file-roller
- mousepad
- papirus-icon-theme
- noto-fonts-cjk
- noto-fonts-emoji
- swayidle
- brightnessctl

Make sure to install yay:

    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

Also, here are the list of the package required to install from yay:

- wlogout
- swaylock-effects
- pokemon-colorscripts-git
- neofetch (optional)

## Installation

1.  After installing the required packages, copy the contents into `~/` or
    `/home/<yourusername>`.
2.  Restart hyprland session or reboot your PC.

## Waybar Features

This theme includes interactable waybar buttons such as

- File Manager
- Sound Controller via pavucontrol
- Wifi Menu
- Bluetooth Menu
- Battery Profile Menu (For laptops that support limit charging)

To enable the feature, simply make the scripts executable

    chmod +x ~/.config/scripts/rofi-wifi.sh
    chmod +x ~/.config/scripts/rofi-bluetooth.sh
    chmod +x ~/.config/scripts/rofi-battery.sh

**(IMPORTANT)**
Battery profile menu requires modifying the file system, basically it needs to execute the script without requiring the root password.

1.  In the terminal, open `sudo visudo`, alternatively you can open `sudo EDITOR=nano visudo`
2.  Paste the code into a new line

        <yourusername> ALL=(ALL) NOPASSWD: /home/<yourusername>/.config/scripts/rofi-battery.sh, \
            /bin/grep, /bin/cp, /usr/bin/tlp

        <yourusername> ALL=(ALL) NOPASSWD: /etc/tlp.conf

    Replace `<yourusername>` into your username

3.  Check if the permission is now registered by opening `sudo -l` in the terminal

If things are working correctly, you can now use the battery profile menu.

## XWayland Apps

If you are using native scale (1) for your monitor, skip this step.

For xwayland apps that doesn't support scaling in wayland (Steam, Discord, etc), we need to disable the automatic scaling for the apps

1.  in hyprland.conf, add this into a new line

        xwayland {
            force_zero_scaling=true
        }

2.  After that, we need to create a desktop shortcut for the app.
3.  Make the script executable (for example, scale-steam.sh in the ~/.config/scripts)
4.  Edit the shortcut file via `sudo nano ~/Desktop/steam.desktop`
5.  Change the Exec values to `Exec=/home/<yourusername>/scripts/scale-steam.sh`

You can make the scripts for the other xwayland apps, you just need to find the command for scaling the apps (scaling command between apps may vary).
