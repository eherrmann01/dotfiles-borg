#!/bin/env bash

export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export TERM=xterm-256color

# Promnpt for package name
package=$(echo "" | rofi -dmenu -i -p "Search package:")

# Check user inpput
if [ -z "$package" ]; then
  echo "No package entered. Exiting." 
  exit 1
fi 

pacseek -s "$package"
