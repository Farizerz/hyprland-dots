#!/bin/bash

FLAG="$HOME/.cache/.post_install_config"
if [[ -f "$FLAG" ]]; then
    exit 0
fi

# Applying themes
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Create user directories
USER_DIR="$HOME/.config/user-dirs.dirs"

read -r -d '' NEW_USER_DIR <<'EOL'
XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/Documents"
XDG_MUSIC_DIR="$HOME/Music"
XDG_PICTURES_DIR="$HOME/Pictures"
XDG_VIDEOS_DIR="$HOME/Videos"
EOL

if [[ -f "$USER_DIR" ]]; then
    if cmp -s <(echo "$NEW_USER_DIR") "$USER_DIR"; then
        :
    else
        echo "$NEW_USER_DIR" > "$USER_DIR"
    fi
else
    echo "$NEW_USER_DIR" > "$USER_DIR"
fi

# Create the XDG directories if they don't exist
xdg_dirs=(Desktop Downloads Templates Public Documents Music Pictures Videos)

for dir in "${xdg_dirs[@]}"; do
    mkdir -p "$HOME/$dir"
done

# Forget previous iwctl connections (Necessary for connecting wifi using nmcli)
iwctl known-networks list | \
  sed -r "s/\x1B\[[0-9;]*[mK]//g" | \
  tail -n +5 | \
  awk 'NF > 0 {print $1}' | \
  while read -r ssid; do
    echo "Forgetting: $ssid"
    iwctl known-networks "$ssid" forget
  done

# Create a flag so the script runs only once
mkdir -p ~/.cache
touch "$FLAG"