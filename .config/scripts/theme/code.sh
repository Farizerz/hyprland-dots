#!/bin/bash

CSS_FILE="$HOME/.config/colors/colors.css"
SETTINGS_FILE="$HOME/.config/Code/User/settings.json"

# Load colors from colors.css into associative array
declare -A colors

while IFS=' ' read -r _ name value; do
  name="${name//;/}"
  value="${value//;/}"
  colors["$name"]="$value"
done < <(grep '@define-color' "$CSS_FILE")

# Helper
get_color() {
  echo "${colors[$1]:-#000000}"
}

# Construct the new color block
read -r -d '' new_block <<EOF
    "workbench.colorCustomizations": {
    "editorGroupHeader.tabsBackground": "$(get_color background)",
    "tab.activeBorderTop": "$(get_color foreground)",
    "tab.activeBackground": "$(get_color foreground)20",
    "tab.inactiveBackground": "$(get_color background)",
    "activityBar.background": "$(get_color background)",
    "activityBar.activeBorder": "$(get_color foreground)",
    "activityBarBadge.background": "$(get_color foreground)",
    "activityBarBadge.foreground": "$(get_color background)",
    "statusBar.background": "$(get_color background)",
    "editor.background": "$(get_color background)",
    "sideBar.background": "$(get_color background)",
    "sideBarSectionHeader.background": "#e5c6be20",
    "panel.background": "$(get_color background)",
    "panelTitle.activeBorder": "$(get_color foreground)",
    "panelTitleBadge.background": "$(get_color foreground)",
    "panelTitleBadge.foreground": "$(get_color background)",
    "terminal.background": "$(get_color background)"
  },
EOF

# Read the whole file, replace the block, then overwrite the file in-place
new_content=$(awk -v block="$new_block" '
  BEGIN { skip = 0 }
  /"workbench.colorCustomizations": \{/ { skip = 1 }
  skip && /\},?/ { skip = 0; print block; next }
  !skip { print }
' "$SETTINGS_FILE")

# Overwrite the file directly
echo "$new_content" > "$SETTINGS_FILE"

echo "✅ In-place update complete: settings.json modified without temp file."
