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

