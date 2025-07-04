!#/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.imwheelrc"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
