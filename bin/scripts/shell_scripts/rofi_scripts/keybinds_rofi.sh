#!/usr/bin/env bash

KEYBINDS="$HOME/.config/i3/keybinds.txt"

# Preprocess: capitalize the action name, trim spaces, show Action<TAB>Key
choice=$(awk -F '|' '{
    action=$1
    key=$2
    sub(/^[ \t]+/, "", action)
    sub(/[ \t]+$/, "", action)
    sub(/^[ \t]+/, "", key)
    sub(/[ \t]+$/, "", key)
    display=toupper(substr(action,1,1)) substr(action,2)
    printf "%-50s %s\n", display, key

}' "$KEYBINDS" \
| sort -f -k1,1 \
| column -t -s $'\t' \
| rofi -dmenu -i -p "i3 Keybinds" -theme ~/.config/rofi/themes/keybinds_app.rasi)
# | rofi -dmenu -i -p "i3 Keybinds" -theme ~/.config/rofi/themes/tokyonight_keybinds.rasi)
# | rofi -dmenu -i -p "i3 Keybinds" -theme ~/.config/rofi/themes/appmenu.rasi)

# Extract the *real* action (3rd column) and run it
#if [[ -n "$choice" ]]; then
#    cmd=$(echo "$choice" | awk -F '|' '{print $3}' | xargs)
#    if [[ -n "$cmd" ]]; then
#        eval "$cmd"
#    fi
#fi

