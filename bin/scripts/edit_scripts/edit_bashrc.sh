#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.bashrc"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
