#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/qtile/config.py"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
