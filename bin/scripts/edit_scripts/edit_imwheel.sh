!#/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.imwheelrc"
cp "$FILE" "$FILE.bak"
nvim "$FILE"
