#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/kitty/kitty.conf"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
