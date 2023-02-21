#!/bin/sh
#
echo "This script is provided without any express warranty or support. Run at your own risk!"
read -p "Press Enter to continue..."
clear
echo "First we install ludusavi...."
flatpak install -y com.github.mtkennerly.ludusavi 

### Checking for SD Card and using storage if available

echo "Checking if SD Card Exists. If it does we will link to that for backup storage"
if [ -d /run/media/mmcblk0p1 ]
then
	echo "SD Card Found, creating directory and linking"
	mkdir /run/media/mmcblk0p1/ludusavi-backup
	ln -s /run/media/mmcblk0p1/ludusavi-backup ~/ludusavi-backup
else
	echo "No SD Card found, using local stoage"
fi

### Deploy backup script and systemd timers
curl --create-dirs -O --output-dir ~/.config/systemd/user/ https://raw.githubusercontent.com/jakepi84/deck-backup/main/data-backup.timer
curl -O --output-dir ~/.config/systemd/user/ https://raw.githubusercontent.com/jakepi84/deck-backup/main/data-backup.service
curl --create-dirs -O --output-dir ~/.local/ https://raw.githubusercontent.com/jakepi84/deck-backup/main/backup.sh

### Confirm downloads

if [ -f ~/.config/systemd/user/data-backup.timer ]; then
    echo "Download of timer complete"
else
	echo "Download failed!!!!"
	exit 0
fi

if [ -f ~/.config/systemd/user/data-backup.service ]; then
    echo "Download of service complete"
else
	echo "Download failed!!!!"
	exit 0
fi

if [ -f ~/.local/backup.sh ]; then
    echo "Download of backup script complete"
else
	echo "Download failed!!!!"
	exit 0
fi

### Initial run of ludusavi
#
clear
echo "***"
echo "---  We will now run ludusavi for the fist time. DO NOT CHANGE THE BACKUP DIRECTORY! Feel free to change any other preferences such as retention settings under the gear. When you are done simply close this window. ---"
read -p "Press Enter to resume ..."
flatpak run com.github.mtkennerly.ludusavi

### Enable the timers and do initial backup

echo "We will now enable automatated backups for 11AM daily and run your first backup..."

systemctl --user daemon-reload
systemctl --user enable --now data-backup.timer
/bin/bash ~/.local/backup.sh

### Complete
#
echo "***"
echo "If you did not run into any errors you are now done. Please return to Game Mode. Thank you."
echo "When you need to restore simply return to desktop mode and open the Ludusavi application"
echo "We will also keep 5 days of backups of your config directory in the ludusavi-backup folder"
read -p "Press Enter to exit..."

exit 0
