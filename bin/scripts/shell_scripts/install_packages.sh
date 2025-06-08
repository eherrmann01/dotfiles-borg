#!/bin/bash
#  ______      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# Install script to restore packages after system reinstall, updated 11/03/2024
# ~/bin/scripts/packages/install_packages.sh

input_file=$(find ~/ -name 'pkglist.txt')

if [[ ! -f "$input_file" ]]; then
    echo "Package list not found, please check path"
    exit 1
fi

echo "installing packages from $input_file..."

sudo pacman -S --needed - < "$input_file"

echo "All packages from $input_file have been installed"
