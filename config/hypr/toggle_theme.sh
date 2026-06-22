#!/bin/bash

HYPR_THEME_POINTER="$HOME/.config/hypr/configs/theme.conf"

HYPR_THEMES_DIR="$HOME/.config/hypr/themes"

WAYBAR_STYLE_TARGET="$HOME/.config/waybar/style.css"
DUNST_CONFIG_TARGET="$HOME/.config/dunst/dunstrc"
FOOT_CONFIG_TARGET="$HOME/.config/foot/foot.ini" 
HYPRPAPER_CONFIG_TARGET="$HOME/.config/hypr/hyprpaper.conf"

DARK_HYPR="$HYPR_THEMES_DIR/dark_hypr.conf"
LIGHT_HYPR="$HYPR_THEMES_DIR/light_hypr.conf"

DARK_WAYBAR_CSS_ABS="$HOME/.config/hypr/themes/dark_waybar.css"
LIGHT_WAYBAR_CSS_ABS="$HOME/.config/hypr/themes/light_waybar.css"

DARK_DUNSTRC="$HYPR_THEMES_DIR/dark_dunstrc"
LIGHT_DUNSTRC="$HYPR_THEMES_DIR/light_dunstrc"

DARK_FOOT_INC="$HOME/.config/hypr/themes/dark_foot.ini"
LIGHT_FOOT_INC="$HOME/.config/hypr/themes/light_foot.ini"

DARK_HYPRPAPER="$HYPR_THEMES_DIR/dark_hyprpaper.conf"
LIGHT_HYPRPAPER="$HYPR_THEMES_DIR/light_hyprpaper.conf"

CURRENT_THEME=$(grep 'source =' "$HYPR_THEME_POINTER" | awk -F'/' '{print $NF}')

if [ "$CURRENT_THEME" == "dark_hypr.conf" ]; then
    NEW_HYPR_SOURCE="source = $LIGHT_HYPR"
    NEW_WAYBAR_CSS_IMPORT='@import url("'"$LIGHT_WAYBAR_CSS_ABS"'");'
    NEW_FOOT_SOURCE="$LIGHT_FOOT_INC"
    NEW_DUNSTRC_SOURCE="$LIGHT_DUNSTRC"
    NEW_HYPRPAPER_SOURCE="$LIGHT_HYPRPAPER"
else
    NEW_HYPR_SOURCE="source = $DARK_HYPR"
    NEW_WAYBAR_CSS_IMPORT='@import url("'"$DARK_WAYBAR_CSS_ABS"'");'
    NEW_FOOT_SOURCE="$DARK_FOOT_INC"
    NEW_DUNSTRC_SOURCE="$DARK_DUNSTRC"
    NEW_HYPRPAPER_SOURCE="$DARK_HYPRPAPER"
fi

echo "$NEW_HYPR_SOURCE" > "$HYPR_THEME_POINTER"

cp "$NEW_DUNSTRC_SOURCE" "$DUNST_CONFIG_TARGET"

cp "$NEW_HYPRPAPER_SOURCE" "$HYPRPAPER_CONFIG_TARGET"

cp "$NEW_FOOT_SOURCE" "$FOOT_CONFIG_TARGET"

hyprctl reload

killall waybar
waybar &

killall dunst
dunst &

hyprctl dispatch exec hyprpaper

