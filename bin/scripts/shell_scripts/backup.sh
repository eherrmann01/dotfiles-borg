#! /bin/bash
# Daily /home backup
rsync  -r -t -p -v --exclude '.local/share/Trash*' --exclude '.cache*'  --progress -s /home/erik/ /mnt/linux_4TB/linuxbackups_current/home/erik/  >> ~erik/Documents/rsync.log 2>&1
touch /mnt/linux_4TB/today.txt
