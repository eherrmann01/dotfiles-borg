#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/picom/picom.conf"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
