#!/bin/bash
# What to backup. 
backup_files="/home/deck/.config/"

# Where to backup to.
dest="~/ludusavi-backup/"

# Create archive filename.
day=$(date +%F)
archive_file="deck-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar czf $dest/$archive_file $backup_files

# Backup Using Ludusavi
flatpak run com.github.mtkennerly.ludusavi backup --force

# Now push the backup to the server
#rsync -avv /$dest/ rsync://xxx.xxx/backup/deck/

### Delete tgz backups older then 5 days
find $dest/ -name "*.tgz" -maxdepth 1 -mtime +5 -delete

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
