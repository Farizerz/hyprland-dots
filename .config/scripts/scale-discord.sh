#!/bin/bash
scale=$(hyprctl monitors | awk  '/scale:/ {print $2; exit}')
# if scale is not detected. back to 1
scale=${scale:-1}

discord --force-device-scale-factor="${scale}"