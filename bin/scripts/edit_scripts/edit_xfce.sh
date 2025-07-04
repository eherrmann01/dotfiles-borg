#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/xfce4/terminalrc"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
