#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/i3/config"
cp "$FILE" "$FILE.bak"
nvim "$FILE"
