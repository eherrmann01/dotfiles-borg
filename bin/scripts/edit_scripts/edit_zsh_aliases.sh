#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.zsh_aliases"
cp "$FILE" "$FILE.bak"
nvim "$FILE"
