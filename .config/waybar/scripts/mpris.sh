#!/bin/bash

title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
url=$(playerctl metadata xesam:url 2>/dev/null)

if [[ -z "$title" ]]; then
  echo "No music playing"
  exit 0
fi

if [[ "$url" == *"youtube.com"* ]]; then
  echo "$title ASDSAD"
else
  echo "$artist - $title ASDASD"
fi