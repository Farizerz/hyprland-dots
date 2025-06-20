#!/bin/bash

# Path to wal colors file and target Rasi file
WAL_COLORS="$HOME/.cache/wal/colors"
RASI_FILE="$HOME/.config/rofi/colors.rasi"

# Check if wal color file exists
if [ ! -f "$WAL_COLORS" ]; then
    echo "❌ No wal color file found at $WAL_COLORS"
    exit 1
fi

# Read wal colors into an array
mapfile -t colors < "$WAL_COLORS"

# Start writing to the Rasi file
{
    echo "* {"
    for i in "${!colors[@]}"; do
        printf "    color%d: %s;\n" "$i" "${colors[$i]}"
    done
    echo "}"
} > "$RASI_FILE"

echo "✔ Rasi theme written to $RASI_FILE with ${#colors[@]} colors"