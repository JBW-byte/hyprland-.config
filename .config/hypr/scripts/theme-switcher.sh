#!/bin/bash
# ~/.config/hypr/scripts/theme-switcher.sh

THEME_DIR="$HOME/.config/hypr/themes"
THEME="$1"

if [ -z "$THEME" ]; then
    notify-send "Theme Switcher" "No theme specified."
    exit 1
fi

if [ ! -d "$THEME_DIR/$THEME" ]; then
    notify-send "Theme Switcher" "Theme '$THEME' not found."
    exit 1
fi

# Apply Hyprland config
ln -sf "$THEME_DIR/$THEME/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"

# GTK theme
if [ -f "$THEME_DIR/$THEME/gtk" ]; then
    GTK_THEME=$(cat "$THEME_DIR/$THEME/gtk")
    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
fi

# Icon theme
if [ -f "$THEME_DIR/$THEME/icons" ]; then
    ICON_THEME=$(cat "$THEME_DIR/$THEME/icons")
    gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"
fi

# Cursor theme
if [ -f "$THEME_DIR/$THEME/cursor" ]; then
    CURSOR_THEME=$(cat "$THEME_DIR/$THEME/cursor")
    gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME"
fi

# Wallpaper
if [ -f "$THEME_DIR/$THEME/wallpaper.jpg" ]; then
    if command -v swww &>/dev/null; then
        swww img "$THEME_DIR/$THEME/wallpaper.jpg" --transition-type fade --transition-duration 1
    elif command -v hyprpaper &>/dev/null; then
        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload "$THEME_DIR/$THEME/wallpaper.jpg"
        hyprctl hyprpaper wallpaper ,"$THEME_DIR/$THEME/wallpaper.jpg"
    fi
fi

# Terminal theme example (e.g., alacritty)
if [ -f "$THEME_DIR/$THEME/terminal.conf" ]; then
    ln -sf "$THEME_DIR/$THEME/terminal.conf" "$HOME/.config/alacritty/colors.yml"
fi

# Reload Hyprland
hyprctl reload

# Notify
notify-send "Theme Switched" "Applied theme: $THEME"
echo "Theme switched to: $THEME"
