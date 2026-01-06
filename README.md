# Hyprland Fariz Setup

https://github.com/user-attachments/assets/548f53e0-539d-489c-8412-569bac5c37d1

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3dfbeb2b-7f84-486f-9cb8-02958fa89382" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b3d2bf97-e24e-4fd6-b5dd-b469bc6bc46f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/7c794ad1-5b5d-4bf9-a2f3-bbd1304fad61" />

## Requirements

Arch Linux with wget installed & connected to the internet.

## Installation

1.  On the terminal, run
    ```
    wget -qO- https://farizerz.github.io/hyprland-dots/getfiles.sh | bash
    ```
2.  During installation process, choose your GPU driver & input your password when prompted.
3.  Your PC will reboot & installation finished.

### ⚠ Note

Installing this setup will overwrite your previous config files (if exists), so it's best to proceed on freshly installed Arch Linux.

## Keybindings

These are the default keybindings inspired by Windows. You can change them in `~/.config/hypr/hyprconfig/keybindings.conf`

### Navigation

| Hotkey                     | Description                      |
| -------------------------- | -------------------------------- |
| `ALT + [0-9]`              | Move to workspace                |
| `` ALT + ` ``              | Move to hidden workspace         |
| `ALT + SHIFT + [0-9]`      | Move window to workspace         |
| `` ALT + SHIFT + ` ``      | Move window to hidden workspace  |
| `ALT + TAB`                | Switch focus between windows     |
| `ALT + Arrow keys`         | Switch focus between windows     |
| `ALT + SHIFT + Arrow keys` | Move windows using arrow keys    |
| `ALT + F4`                 | Close window                     |
| `ALT + V`                  | Toggle floating window           |
| `ALT + SHIFT + P`          | Toggle pseudo                    |
| `ALT + J`                  | Toggle tiling direction          |
| `ALT + U / P`              | Resize split window horizontally |
| `ALT + I / O`              | Resize split window vertically   |
| `ALT + Mouse scroll`       | Scroll through workspaces        |
| `ALT + Left mouse`         | Drag window                      |
| `ALT + Right mouse`        | Resize window                    |
| `F11`                      | Fullscreen window                |

### Main Modifier

| Hotkey                 | Description                                                     |
| ---------------------- | --------------------------------------------------------------- |
| `SUPER + Q`            | Launch terminal                                                 |
| `SUPER + R`            | App launcher                                                    |
| `SUPER + E`            | File explorer / manager                                         |
| `SUPER + Esc`          | Power menu                                                      |
| `SUPER + P`            | Battery profile menu                                            |
| `SUPER + W`            | Wifi menu                                                       |
| `SUPER + B`            | Bluetooth menu                                                  |
| `SUPER + .`            | Emoji menu                                                      |
| `SUPER + TAB`          | Wallpaper menu                                                  |
| `SUPER + SHIFT + TAB`  | Shuffle random wallpaper                                        |
| `SUPER + T`            | Visual style menu                                               |
| `SUPER + M`            | Toggle microphone                                               |
| `SUPER + Print screen` | Screenshot                                                      |
| `SUPER + SHIFT + S`    | Screen snipping tool                                            |
| `SUPER + C`            | Color picker                                                    |
| `SUPER + X`            | Start waybar                                                    |
| `SUPER + SHIFT + X`    | Restart waybar                                                  |
| `SUPER + D`            | Toggle laptop monitor on/off (if connected to external display) |

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

Version 1.9.2

1.  Updated window & layer rule config to v3
