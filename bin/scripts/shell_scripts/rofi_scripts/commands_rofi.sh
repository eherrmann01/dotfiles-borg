#  ______      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# Rofi dialog that shows useful Linux commands - updated 10/25/2025
# ~/bin/scripts/shell_scripts/commands_rofi.sh

#!/usr/bin/env bash

COMMANDS="$HOME/Documents/useful_commands.txt"

# Create "Description | Command" list for Rofi
choice=$(awk '
    /^#/ { desc = substr($0, 3) }      # remove leading "# "
    /^[^#]/ { print desc " | " $0 }    # print description + separator + command
' "$COMMANDS" | sort -f \
    | rofi -dmenu -i -p "Useful Commands" \
    -theme ~/.config/rofi/themes/commands_app.rasi)

# Exit if user canceled
[ -z "$choice" ] && exit

# Extract the command (after the separator)
cmd="${choice#*| }"

