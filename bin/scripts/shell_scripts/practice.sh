#!/bin/bash
# new.sh

# This is a test script

# Variables
myTerm="xfce4-terminal"

#$myTerm -e htop & 
#firefox &
#sleep 3 
#geany &

myDir='/home/erik/.config'
options=$(cd ${myDir} && /bin/ls -d */ | cut -d " " -f 1)
choice=$(echo -e "${options[@]}" | dmenu -i -p 'My Config Direstories')
