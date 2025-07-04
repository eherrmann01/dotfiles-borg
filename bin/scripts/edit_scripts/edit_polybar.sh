#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/polybar/config.ini"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"

