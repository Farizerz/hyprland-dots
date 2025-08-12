# Hyprland Fariz Theme

![image](https://github.com/user-attachments/assets/f8f27dea-39aa-4f0f-8d14-a82987eee240)

![image](https://github.com/user-attachments/assets/568f8a2c-9a19-48e8-a497-078777ce86a1)

![image](https://github.com/user-attachments/assets/485de9db-c55a-48d6-a1d7-fdf33cb82bca)

## Requirements

Arch Linux already installed.

## Installation

1.  You can either clone the repo, or download and copy the contents into the root folder (`~/` or
    `/home/<yourusername>`).
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

Version 1.7.1

1.  Added multiple web apps (ChatGPT, Netflix, Telegram, Whatsapp)
2.  Add translucent windowrule for web apps & fix floating windowrule
