#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.vimrc"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
