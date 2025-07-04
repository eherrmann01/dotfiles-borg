!#/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/nvim/init.lua"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
