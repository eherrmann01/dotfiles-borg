#!/bin/bash
#  ______      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# Script to generate a list of all installed packages on Arch Linux, Updated 05/24/2025
# ~/bin/scripts/shell_scripts/getpkg.sh

# Set output file name and location
output_file="$HOME/bin/scripts/packages/pkglist.txt"

# Get list of install3ed packages and their dependancies
echo "Generating list of installed packages..."
pacman -Qqe > "$output_file"

echo "List of installed packages saved to $output_file"

