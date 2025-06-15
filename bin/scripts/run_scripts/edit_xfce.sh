#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/xfce4/terminalrc"
cp "$FILE" "$FILE.bak"
nvim "$FILE"
