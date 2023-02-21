#!/bin/sh
echo "First we install ludusavi...."
flatpak install -y ludusavi

### Checking for SD Card and using storage if available

echo "Checking if SD Card Exists. If it does we will link to that for backup storage"
if [ -d "/run/media/mmcblk0p1" ]
	echo "SD Card Found, creating directory and linking"
	mkdir /run/media/mmcblk0p1/ludusavi-backup
	ln -s /run/media/mmcblk0p1/ludusavi-backup ~/ludusavi-backup
else
	echo "No SD Card found, using local stoage"
fi

### Deploy backup script and systemd timers
curl --create-dirs -O --output-dir ~/.config/systemd/user/ https://github.com/jakepi84/deck-backup/raw/main/data-backup.timer
curl --output-dir ~/.config/systemd/user/ https://github.com/jakepi84/deck-backup/raw/main/data-backup.service
curl --output-dir ~/.local/ https://github.com/jakepi84/deck-backup/raw/main/backup.sh

### Initial run of ludusavi
#
echo "---  We will now run ludusavi for the fist time. DO NOT CHANGE THE BACKUP DIRECTORY! Feel free to change any other preferences such as retention settings under the gear. When you are done simply close this window. ---"
read -p "Press any key to resume ..."
flatpak run com.github.mtkennerly.ludusavi

### Enable the timers and do initial backup

echo "We will now enable automatated backups for 11AM daily and run your first backup..."

systemctl --user daemon-reload
systemctl --user enable --now data-backup.timer
/bin/bash ~/.local/backup.sh

### Complete
#
echo "If you did not run into any errors you are now done. Please return to Game Mode. Thank you."

exit 0
