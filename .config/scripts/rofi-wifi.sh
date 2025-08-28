#!/bin/bash

# Thanks to ericmurphyxyz

notify-send "Getting list of available Wi-Fi networks..."
# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/󰖩 /g" | sed "s/  //g" | sed "/--/d")

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
  toggle="󰖪  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
  toggle="󰖩  Enable Wi-Fi"
fi

forget_option="󰅛  Forget Wi-Fi"

separator="─────────────────────────────────────────"

# Use rofi to select wifi network
chosen_network=$(echo -e "$toggle\n$forget_option\n$separator\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 2 -p "Wi-Fi ")

# Get name of connection
read -r chosen_id <<<"${chosen_network:3}"

if [ -z "$chosen_network" ]; then
  exit
elif [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
  nmcli radio wifi on
elif [ "$chosen_network" = "$separator" ]; then
  echo 'no wifi chosen.'
elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
  nmcli radio wifi off
elif [ "$chosen_network" = "$forget_option" ]; then
  # Let user select which saved network to forget
  saved_connections=$(nmcli -g NAME connection | grep -v "^lo$")
  to_forget=$(echo "$saved_connections" | rofi -dmenu -p "Forget which network? ")
  if [ -n "$to_forget" ]; then
    nmcli connection delete "$to_forget" && notify-send "Wi-Fi Forgotten" "\"$to_forget\" has been removed."
  fi
else
  success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
  saved_connections=$(nmcli -g NAME connection)
  if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
    nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
  else
    if [[ "$chosen_network" =~ "" ]]; then
      wifi_password=$(rofi -dmenu -p "Password: ")
    fi
    output=$(nmcli device wifi connect "$chosen_id" password "$wifi_password" 2>&1)
    if echo "$output" | grep -qi "successfully"; then
      notify-send "Connection Established" "$success_message"
      # check if the wifi is captive portal
      if ! ping -q -c 1 -W 1 archlinux.org >/dev/null; then
        notify-send "Captive Portal Detected" "Opening browser for Wi-Fi login..."
        # Replace with your preferred browser
        chromium http://neverssl.com
      fi
    else
      notify-send "Connection Failed" "$(echo "$output" | grep -m1 -oP '(?<=Error: ).*' || echo 'Could not connect to Wi-Fi.')"
      nmcli connection delete "$chosen_id"
    fi
  fi
fi
