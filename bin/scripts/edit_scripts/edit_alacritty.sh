#!/bin/bash
# This file is used by xmenu/Appmenu
FILE="$HOME/.config/alacritty/alacritty.toml"
cp -i "$FILE" "$FILE.bak"
nvim "$FILE"
