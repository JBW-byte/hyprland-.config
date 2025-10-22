#!/bin/bash
# ~/.config/hypr/scripts/theme-menu.sh

THEME_DIR="$HOME/.config/hypr/themes"
MENU_TOOL="rofi-wayland"  # or "rofi" if you prefer

# Choose a theme
if [ "$MENU_TOOL" = "rofi-wayland" ]; then
    THEME=$(ls "$THEME_DIR" | wofi --dmenu --prompt "Select Theme:")
else
    THEME=$(ls "$THEME_DIR" | rofi -dmenu -p "Select Theme:")
fi

# If cancelled, exit
[ -z "$THEME" ] && exit 0

# Run the switcher
"$HOME/.config/hypr/scripts/theme-switcher.sh" "$THEME"
