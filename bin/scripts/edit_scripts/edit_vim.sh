#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.vimrc"
cp "$FILE" "$FILE.bak"
nvim "$FILE"
