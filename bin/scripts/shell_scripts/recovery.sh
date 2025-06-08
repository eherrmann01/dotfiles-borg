#!/bin/bash

# Cover Your Ass(ets) Mounting Script v1.0
# This script attempts to ready a Linux system for cya by mounting the filesystem

# Create mount point
sudo mkdir -p /mnt/cya

# Mount root filesystem
sudo mount /dev/sda1 /mnt/cya/

# Add additional mount calls below this line - mount into /mnt/cya/CUSTOM_DIRECTORY
# Dont forget to add create directory before mounting if it doesnt already exist!
# Ex: sudo mkdir /mnt/cya/backups
# Ex: sudo mount /dev/sda4 /mnt/cya/backups/

echo "Run the cya recovery program by issuing the following command:"
echo "sudo /mnt/cya/home/cya/cya restore"

# Run restore
sudo /mnt/cya/home/cya/cya restore
