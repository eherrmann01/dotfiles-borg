#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/polybar/config.ini"
cp "$FILE" "$FILE.bak"
nvim "$FILE"

