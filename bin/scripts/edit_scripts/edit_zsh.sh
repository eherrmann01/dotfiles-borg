#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.zshrc"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
