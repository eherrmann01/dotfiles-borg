#!/bin/sh
echo "Backing up new photos to /mnt/Storage_8TB/Pictures..."

# Clear the log before each run
: > /mnt/Storage_8TB/Pictures/rsync_photos.log

rsync -ah --info=NAME \
  --log-file="/mnt/Storage_8TB/Pictures/rsync_photos.log" \
  --exclude='$RECYCLE.BIN/' \
  --exclude='*/$RECYCLE.BIN/' \
  --exclude='*/$RECYCLE.BIN/*' \
  --exclude='found.*/' \
  --exclude='linuxutilities*' \
  --exclude='System Volume Information' \
  /mnt/Photography/ /mnt/Storage_8TB/

COPIED=$(grep -cve '^\s*$' /mnt/Storage_8TB/Pictures/rsync_photos.log)

if [ "$COPIED" -eq 1 ]; then
  echo "Backup completed, 1 item copied."
else
  echo "Backup completed, $COPIED items copied."
fi

