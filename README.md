# Hyprland Fariz Setup

https://github.com/user-attachments/assets/548f53e0-539d-489c-8412-569bac5c37d1

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3dfbeb2b-7f84-486f-9cb8-02958fa89382" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b3d2bf97-e24e-4fd6-b5dd-b469bc6bc46f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/7c794ad1-5b5d-4bf9-a2f3-bbd1304fad61" />

## Requirements

Freshly installed Arch Linux.

## Installation

1.  You can either clone the repo, or download and copy the contents into the root folder (`~/` or
    `/home/<yourusername>`).
2.  On the terminal, run `bash ~/install.sh`
3.  Restart hyprland session or reboot your PC.

## Waybar Features

This setup includes interactable waybar buttons such as

- App Launcher
- Sound Controller via pavucontrol
- Wifi Menu
- Bluetooth Menu
- Battery Profile Menu (For laptops that support limit charging)
- System Update Checker
- Toggle Microphone

## XWayland Apps

If you are using native scale (1) for your monitor, skip this step.

For xwayland apps that doesn't support scaling in wayland (Steam, Discord, etc), we need to disable the automatic scaling for the apps

1.  Create or edit a shortcut for the app (via ~/.local/share/applications or /usr/share/applications).
2.  Make the script executable (for example, scale-steam.sh in the ~/.config/scripts)
3.  Edit the shortcut file via `sudo nano ~/Desktop/steam.desktop`
4.  Change the Exec values to `Exec=/home/<yourusername>/scripts/scale-steam.sh`

You can make the scripts for the other xwayland apps, you just need to find the command for scaling the apps (scaling command between apps may vary).

## Changelogs

Version 1.7.3

1.  Removed redundant applications on install-package.sh
2.  Added initial pywal cache & post-install configurations
