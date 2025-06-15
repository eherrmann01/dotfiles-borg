#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/kitty/kitty.conf"
cp "$FILE" "$FILE.bak"
nvim "$FILE"
