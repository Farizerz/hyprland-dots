#!/bin/bash

sleep 1

# Only run if we have internet
ping -q -c1 archlinux.org &>/dev/null || exit

# Get update counts
pacman_count=$(checkupdates 2>/dev/null | wc -l)
aur_count=$(yay -Qua 2>/dev/null | wc -l)

total=$(($pacman_count + $aur_count))

if [ "$total" -eq 0 ]; then
  exit 0
fi

# Output JSON for Waybar
echo "{\"text\": \"$total\", \"tooltip\": \"Official updates: $pacman_count\\nAUR updates: $aur_count\"}"
