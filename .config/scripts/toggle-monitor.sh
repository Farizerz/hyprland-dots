#!/bin/bash

monitors=$(hyprctl monitors)

if echo "$monitors" | grep -q "^Monitor eDP-1"; then
  hyprctl keyword monitor "eDP-1,disable"
else
  hyprctl keyword monitor "eDP-1,2880x1620@120,auto,1.5"
fi