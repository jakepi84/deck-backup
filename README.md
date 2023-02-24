# deck-backup
Set of scripts to backup your steam-deck
Script to deploy backups to your Steam Deck. Script is pretty basic and really just helps you install Ludusavi.

The scirpt is pretty simple, does the following:
1. Uses flatpak, install ludusavi
2. Check if you have an SD Card, if so create a link for the ludusavi backup folder from your home to the sd card.
3. Download and install some systemd timers to run the backup every 12 hours.
4. Download the "backup.sh" script to ~./local
5. Opens ludusavi so you can configure it.
6. Enables the timers and runs an initial backup.

Install:
To install on your Deck first enter desktop mode. Click the "K" icon and open Konsole. Run the following:

curl https://raw.githubusercontent.com/jakepi84/deck-backup/main/deploy-deck-backup.sh -o deploy-deck-bash.sh && bash deploy-deck-bash.sh
