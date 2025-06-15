#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/picom/picom.conf"
cp "$FILE" "$FILE.bak"
nvim "$FILE"
