CAVA_CONFIG="$HOME/.config/cava/config"
WAL_COLORS="$HOME/.cache/wal/colors.css"

# Extract color from colors.css
gradientColor1=$(grep -Po -- '--color13:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")
gradientColor2=$(grep -Po -- '--color15:\s*\K#[0-9a-fA-F]+' "$WAL_COLORS")

# Make sure color was found
if [[ -z "$gradientColor1" || -z "$gradientColor2" ]]; then
    echo "color not found in $WAL_COLORS"
    exit 1
fi

# Replace color in cava config
awk -v new_color1="$gradientColor1" -v new_color2="$gradientColor2" '
  $0 ~ /^\s*gradient_color_1\s*=/ {
      sub(/#[0-9a-fA-F]{6}/, new_color1)
  }
  /^\s*gradient_color_2\s*=/ {
      sub(/#[0-9a-fA-F]{6}/, new_color2)
  }
  { print }
' "$CAVA_CONFIG" > "$CAVA_CONFIG.tmp" && mv "$CAVA_CONFIG.tmp" "$CAVA_CONFIG"