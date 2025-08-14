#!/usr/bin/env bash
#             __ _       _     _            _              _   _
#  _ __ ___  / _(_)     | |__ | |_   _  ___| |_ ___   ___ | |_| |__
# | '__/ _ \| |_| |_____| '_ \| | | | |/ _ \ __/ _ \ / _ \| __| '_ \
# | | | (_) |  _| |_____| |_) | | |_| |  __/ || (_) | (_) | |_| | | |
# |_|  \___/|_| |_|     |_.__/|_|\__,_|\___|\__\___/ \___/ \__|_| |_|
#
# Author: Nick Clyde (clydedroid)
#
# A script that generates a rofi menu that uses bluetoothctl to
# connect to bluetooth devices and display status info.
#
# Inspired by networkmanager-dmenu (https://github.com/firecat53/networkmanager-dmenu)
# Thanks to x70b1 (https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/system-bluetooth-bluetoothctl)
#
# Depends on:
#   Arch repositories: rofi, bluez-utils (contains bluetoothctl), bc

trap 'close_terminal' EXIT

# Constants
divider="─────────────────────────────────────────"
goback="Back"

# Checks if bluetooth controller is powered on
power_on() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        return 0
    else
        return 1
    fi
}

# Toggles power state
toggle_power() {
    if power_on; then
        bluetoothctl power off
        show_menu
    else
        if rfkill list bluetooth | grep -q 'blocked: yes'; then
            rfkill unblock bluetooth && sleep 3
        fi
        bluetoothctl power on
        show_menu
    fi
}

TERMINAL=$(grep '^\$terminal' ~/.config/hypr/hyprconfig/default-programs.conf | awk -F'= ' '{print $2}' | tr -d ' ')

# Toggles scanning state
toggle_scan() {
    $TERMINAL --title 'bluetoothctl' -e bash -c bluetoothctl &
    notify-send "Scanning list of available devices..."
    bluetoothctl pairable on
    bluetoothctl discoverable on
    bluetoothctl --timeout 5 scan on
    echo "Scanning..."
    show_menu
}

# Checks if a device is connected
device_connected() {
    device_info=$(bluetoothctl info "$1")
    if echo "$device_info" | grep -q "Connected: yes"; then
        return 0
    else
        return 1
    fi
}

# Toggles device connection
toggle_connection() {
    if device_connected "$1"; then
        bluetoothctl untrust "$1"
        bluetoothctl disconnect "$1"
        notify-send "$device_name_nospace disconnected."
        device_menu "$device"
    else
        bluetoothctl trust "$1"
        bluetoothctl connect "$1"
        notify-send "$device_name_nospace connected."
        device_menu "$device"
    fi
}

# Checks if a device is paired
device_paired() {
    device_info=$(bluetoothctl info "$1")
    if echo "$device_info" | grep -q "Paired: yes"; then
        echo "Remove Device"
        return 0
    else
        echo "Pair Device"
        return 1
    fi
}

# Toggles device paired state
toggle_paired() {
    if device_paired "$1"; then
        bluetoothctl remove "$1"
        notify-send "$device_name_nospace removed."
        show_menu
    else
        notify-send "Pairing $device_name_nospace..."
        bluetoothctl agent NoInputNoOutput
        bluetoothctl default-agent
        bluetoothctl trust "$1"
        pair_output=$(bluetoothctl pair "$1" 2>&1)
        
        if echo "$pair_output" | grep -iqE "failed|not available|error"; then
            notify-send "❌ Pairing failed for $device_name_nospace"
            show_menu
            return 1
        fi
        bluetoothctl connect "$1"
        notify-send "$device_name_nospace paired."
        timeout 1 device_menu "$device"
    fi
}

# Prints a short string with the current bluetooth status
# Useful for status bars like polybar, etc.
print_status() {
    if power_on; then
        printf ''

        paired_devices_cmd="devices Paired"
        # Check if an outdated version of bluetoothctl is used to preserve backwards compatibility
        if (( $(echo "$(bluetoothctl version | cut -d ' ' -f 2) < 5.65" | bc -l) )); then
            paired_devices_cmd="paired-devices"
        fi

        mapfile -t paired_devices < <(bluetoothctl $paired_devices_cmd | grep Device | cut -d ' ' -f 2)
        counter=0

        for device in "${paired_devices[@]}"; do
            if device_connected "$device"; then
                device_alias=$(bluetoothctl info "$device" | grep "Alias" | cut -d ' ' -f 2-)

                if [ $counter -gt 0 ]; then
                    printf ", %s" "$device_alias"
                else
                    printf " %s" "$device_alias"
                fi

                ((counter++))
            fi
        done
        printf "\n"
    else
        echo ""
    fi
}

# A submenu for a specific device that allows connecting, pairing, and trusting
device_menu() {
    device=$1

    # Get device name and mac address
    device_name=$(echo "$device" | cut -d ' ' -f 3-)
    device_name_nospace=$(echo "$device_name" | awk '{$1=$1; print}')
    mac=$(echo "$device" | cut -d ' ' -f 2)

    # Build options
    if device_connected "$mac"; then
        connected="Disconnect Device"
    else
        connected="Connect Device"
    fi
    paired=$(device_paired "$mac")
    trusted=$(device_trusted "$mac")

    if device_paired "$mac"; then
        options="$connected\n$paired\n$divider\n$goback\nExit"
    else
        options="$paired\n$divider\n$goback\nExit"
    fi

    # Open rofi menu, read chosen option
    chosen="$(echo -e "$options" | $rofi_command "$device_name ")"

    # Match chosen option to command
    case "$chosen" in
        "" | "$divider")
            echo "No option chosen."
            ;;
        "$connected")
            toggle_connection "$mac"
            ;;
        "$paired")
            toggle_paired "$mac"
            ;;
        "$goback")
            show_menu
            ;;
    esac
}

# Opens a rofi menu with current bluetooth status and options to connect
show_menu() {
    # Get menu options
    if power_on; then
        power="Disable Bluetooth"

        # Human-readable names of devices, one per line
        # If scan is off, will only list paired devices
        devices=$(bluetoothctl devices | grep Device | cut -d ' ' -f 3-)

        # Get controller flags
        scan='Scan'
        pairable=$(pairable_on)
        discoverable=$(discoverable_on)

        # Options passed to rofi
        options="$power\n$scan\n$divider\n$devices"
    else
        power="Enable Bluetooth"
        options="$power\nExit"
    fi

    # Open rofi menu, read chosen option
    chosen="$(echo -e "$options" | $rofi_command "Bluetooth ")"

    # Match chosen option to command
    case "$chosen" in
        "" | "$divider")
            echo "No option chosen."
            ;;
        "$power")
            toggle_power
            ;;
        "$scan")
            toggle_scan
            ;;
        "$discoverable")
            toggle_discoverable
            ;;
        "$pairable")
            toggle_pairable
            ;;
        *)
            device=$(bluetoothctl devices | grep "$chosen")
            # Open a submenu if a device is selected
            if [[ $device ]]; then device_menu "$device"; fi
            ;;
    esac
}

close_terminal() {
    bluetoothctl scan off
    bluetoothctl pairable off
    bluetoothctl discoverable off
    hyprctl clients -j | jq -r '.[] | select(.title | test("bluetoothctl"; "i")) | .address' | while read addr; do hyprctl dispatch closewindow address:$addr; done
}

# Rofi command to pipe into, can add any options here
rofi_command="rofi -dmenu $* -p"

case "$1" in
    --status)
        print_status
        ;;
    *)
        show_menu
        ;;
esac