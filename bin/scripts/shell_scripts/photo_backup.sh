#/bin/sh
echo "Backing up new photos to /mnt/Storage_8TB/Pictures..."
rsync -ah \
  --log-file=rsync_photos.log \
  --exclude='$RECYCLE.BIN/' \
  --exclude='*/$RECYCLE.BIN/' \
  --exclude='*/$RECYCLE.BIN/*' \
  --exclude='found.*/' \
  --exclude='linuxutilities*' \
  --exclude='System Volume Information' \
  /mnt/Photography/ /mnt/Storage_8TB/

COPIED=$(grep -c '>f' rsync_photos.log)
echo "Backup completed, $COPIED files copied."
