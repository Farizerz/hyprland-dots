#!/bin/bash

# Thanks to ulinaaron

# Function to calculate distance between two RGB colors
color_distance() {
    input=($1)
    color=($2)
    distance=$(( (${input[0]} - ${color[0]})**2 + (${input[1]} - ${color[1]})**2 + (${input[2]} - ${color[2]})**2 ))
    echo $distance
}

# Color matching script
get_closest_color() {
    input_rgb=($1)

    colors=(
        "adwaita 147 192 234" 
        "black 79 79 79" 
        "blue 82 148 226" 
        "bluegrey 96 125 139" 
        "breeze 87 184 236" 
        "brown 174 142 108" 
        "carmine 163 0 2" 
        "cyan 0 188 212" 
        "darkcyan 69 171 183" 
        "deeporange 235 102 55" 
        "green 135 77 88" 
        "grey 142 142 142" 
        "indigo 92 107 192" 
        "magenta 202 113 223" 
        "nordic 129 161 193" 
        "orange 238 146 58" 
        "palebrown 209 191 174" 
        "paleorange 238 202 143" 
        "pink 240 98 146" 
        "red 226 82 82" 
        "teal 22 160 133" 
        "violet 126 87 194" 
        "white 228 228 228" 
        "yaru 151 53 82" 
        "yellow 249 189 48"
    )

    closest_color=""
    min_distance=999999
    for color in "${colors[@]}"
    do
        color_name="${color%% *}"
        color_rgb=(${color#* })
        distance=$(color_distance "${input_rgb[*]}" "${color_rgb[*]}")
        if [ $distance -lt $min_distance ]; then
            min_distance=$distance
            closest_color=$color_name
        fi
    done

    echo $closest_color
}

# Get the closest color for the provided input color
input_color=$1 # Example input color in hex
input_rgb=($(printf "%d %d %d" 0x${input_color:1:2} 0x${input_color:3:2} 0x${input_color:5:2}))
input_color_name=$(get_closest_color "${input_rgb[*]}")

# Use the closest color name in the papirus-folders command
papirus-folders -C $input_color_name --theme Papirus-Dark