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
    "tab.activeBorder": "#00000000",
    "tab.activeBorderTop": "$(get_color color14)",
    "tab.activeBackground": "$(get_color foreground)00",
    "tab.activeForeground": "$(get_color foreground)",
    "tab.hoverBackground": "$(get_color foreground)00",
    "tab.inactiveBackground": "#00000095",
    "tab.inactiveForeground": "$(get_color foreground)50",
    "tab.border": "#00000000",
    "activityBar.background": "$(get_color background)",
    "activityBar.activeBorder": "$(get_color foreground)",
    "activityBar.border": "$(get_color foreground)20",
    "activityBarBadge.background": "$(get_color foreground)",
    "activityBarBadge.foreground": "$(get_color background)",
    "editor.background": "$(get_color background)",
    "editor.lineHighlightBorder": "#00000000",
    "editor.lineHighlightBackground": "$(get_color foreground)10",
    "editor.selectionBackground": "$(get_color foreground)50",
    "editorGroup.border": "#000000",
    "editorGroupHeader.border": "#00000000",
    "editorGroupHeader.tabsBackground": "$(get_color background)",
    "editorGroupHeader.tabsBorder": "#00000000",
    "editorIndentGuide.background1": "$(get_color foreground)20",
    "editorIndentGuide.activeBackground1": "$(get_color foreground)50",
    "editorLineNumber.activeForeground": "$(get_color color14)",
    "editorLineNumber.dimmedForeground": "$(get_color color14)40",
    "editorLineNumber.foreground": "$(get_color color14)70",    
    "editorStickyScroll.shadow": "#00000000",
    "editorSuggestWidget.background": "$(get_color background)",
    "list.inactiveSelectionBackground": "#ffffff15",
    "list.activeSelectionBackground": "#ffffff30",
    "list.focusBackground": "#ffffff20",
    "list.focusOutline": "#00000000",
    "list.hoverBackground": "#ffffff20",
    "scrollbar.shadow": "#00000000",
    "scrollbarSlider.background": "$(get_color foreground)20",
    "scrollbarSlider.hoverBackground": "$(get_color foreground)30",
    "scrollbarSlider.activeBackground": "$(get_color foreground)30",
    "sideBar.background": "$(get_color background)",
    "sideBar.border": "$(get_color foreground)20",
    "sideBarSectionHeader.background": "#ffffff20",
    "statusBar.background": "$(get_color background)",
    "statusBar.border": "$(get_color foreground)20",
    "statusBar.foreground": "$(get_color foreground)",
    "statusBarItem.remoteForeground": "$(get_color background)",
    "statusBarItem.remoteBackground": "$(get_color foreground)80",
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
