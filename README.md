# Hyprland Fariz Theme

![image](https://github.com/user-attachments/assets/f8f27dea-39aa-4f0f-8d14-a82987eee240)

![image](https://github.com/user-attachments/assets/568f8a2c-9a19-48e8-a497-078777ce86a1)

![image](https://github.com/user-attachments/assets/485de9db-c55a-48d6-a1d7-fdf33cb82bca)

## Requirements

Arch Linux already installed.

## Installation

1.  Copy the contents into the `~/` or
    `/home/<yourusername>`.
2.  On the terminal, run `bash ~/install.sh`
3.  Restart hyprland session or reboot your PC.

## Waybar Features

This theme includes interactable waybar buttons such as

- File Manager
- Sound Controller via pavucontrol
- Wifi Menu
- Bluetooth Menu
- Battery Profile Menu (For laptops that support limit charging)
- System Update Checker
- Toggle Wifi

## XWayland Apps

If you are using native scale (1) for your monitor, skip this step.

For xwayland apps that doesn't support scaling in wayland (Steam, Discord, etc), we need to disable the automatic scaling for the apps

1.  Create or edit a shortcut for the app (via ~/.local/share/applications or /usr/share/applications).
2.  Make the script executable (for example, scale-steam.sh in the ~/.config/scripts)
3.  Edit the shortcut file via `sudo nano ~/Desktop/steam.desktop`
4.  Change the Exec values to `Exec=/home/<yourusername>/scripts/scale-steam.sh`

You can make the scripts for the other xwayland apps, you just need to find the command for scaling the apps (scaling command between apps may vary).

## Changelogs

Version 1.5.2

1.  Moved system scripts to ~/.config/scripts/system-scripts/
2.  Fixed rofi-wifi bug where user unable to input password
3.  Removed unnecessary permissions on visudo during installation process
4.  Adjusted rofi-battery condition checking
5.  Fixed sleep behavior user sleeps the laptop and closing the lid, it wakes up
6.  Added post-update script to ensure if hyprland.desktop is overwritten to default `Exec=Hyprland` after update, replace it back using custom-boot.sh
