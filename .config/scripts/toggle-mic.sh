#!/bin/bash

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

sleep 0.2

# Check mute status
if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q '\[MUTED\]'; then
    notify-send "Mic disabled."
else
    pactl set-source-volume @DEFAULT_SOURCE@ 30%
    notify-send "Mic enabled."
fi
