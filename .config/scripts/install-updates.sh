#!/bin/bash

# Check internet
ping -q -c1 archlinux.org &>/dev/null || {
  echo "No internet."
  exit 1
}

# Get update lists
pacman_updates=$(checkupdates 2>/dev/null)
aur_updates=$(yay -Qua 2>/dev/null)

# Count them
pacman_count=$(echo "$pacman_updates" | sed '/^\s*$/d' | wc -l)
aur_count=$(echo "$aur_updates" | sed '/^\s*$/d' | wc -l)
total=$(($pacman_count + $aur_count))

# If no updates
if [ "$total" -eq 0 ]; then
  echo "✅ System is up to date."
  sleep 2
  exit 0
fi

# Display result
echo "📦 Total updates: $total"
echo "👉 Official repo packages ($pacman_count):"
echo "$pacman_updates"
echo
echo "🌐 AUR packages ($aur_count):"
echo "$aur_updates"
echo

# Menu
echo "What do you want to update?"
echo "1) Update Pacman packages (official)"
echo "2) Update AUR packages (yay -Sua)"
echo "3) Update all packages (yay -Syu)"
echo "4) Cancel"
read -rp "Enter choice [1-4]: " choice

post_update() {
  sleep 0.5
  waybar & disown
  echo "✅ Update finished."
  sleep 2
  exit 0
}

case "$choice" in
  1)
    echo "🔃 Updating Pacman packages..."
    sudo pacman -Syu --noconfirm
    pkill waybar
    post_update
    ;;
  2)
    echo "🔃 Updating AUR packages..."
    yay -Sua --noconfirm
    pkill waybar
    post_update
    ;;
  3)
    echo "🔃 Updating everything..."
    yay -Syu --noconfirm
    pkill waybar
    post_update
    ;;
  4)
    echo "❌ Update cancelled."
    sleep 2
    exit 0
    ;;
  *)
    echo "❓ Invalid choice."
    sleep 2
    exit 1
    ;;
esac