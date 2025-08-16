#!/bin/bash
#  ______      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# Install script to restore packages form the AUR after system reinstall, updated 08/16/2025
# ~/bin/scripts/packages/install_aur_packages.sh

# Find the most recent package list file
input_file=$(find ~/ -maxdepth 2 -type f -name 'aur_packages*.txt' -printf '%T@ %p\n' \
    | sort -nr \
    | head -n1 \
    | cut -d ' ' -f2-)

if [[ -z "$input_file" || ! -f "$input_file" ]]; then
    echo "Package list not found, please check path"
    exit 1
fi

echo "Installing packages from $input_file..."

# Use yay to install AUR packages, ignoring already installed ones
yay -S --needed $(< "$input_file")

echo "All packages from $input_file have been installed."
