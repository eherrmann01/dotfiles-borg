#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/qtile/config.py"
cp "$FILE" "$FILE.bak"
nvim "$FILE"
