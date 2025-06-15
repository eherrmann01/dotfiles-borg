!#/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/nvim/init.lua"
cp "$FILE" "$FILE.bak"
nvim "$FILE"
