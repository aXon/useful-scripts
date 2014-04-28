#!/usr/local/bin/bash
# reliable file transfer

# set PATH as cron does only have a limited one set up
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin
# test if rsync is already running with generic PID testing script
source /some/where/pid.sh
# use a differnt method: ps aux and the command as argument
RSYNC_CMD='rsync --ignore-errors --bwlimit=550 --partial --progress --compress --exclude-from=/some/where/exclude_rsync --delete-after --fuzzy --archive --hard-links --sparse --xattrs --rsh="ssh -p 2322" /source/ user@server:/target/' # this needs to match the actual command

ps aux | grep -v grep | grep -e "'$RSYNC_CMD'"
PS_EXIT_CODE=$?
if [ $PS_EXIT_CODE -eq 0 ]; then
 echo Rsync already running as a different user, exiting.
 exit
fi

# locations of local and remote directories and rsync options
remote_dir="user@server:/target/"
local_dir="/source/"
exclude_loc="/some/where/exclude_rsync"
logfile=/var/log/rsync.log


# logging
echo "Rsync started for: $local_dir -> $remote_dir (`date`)" >> $logfile

# try rsync for x times
I=0
MAX_RESTARTS=5
LAST_EXIT_CODE=1
TIMEOUT_SECONDS=600
while [ $I -le $MAX_RESTARTS ]
do
  I=$(( $I + 1 ))
  echo $I. start of rsync
  rsync --prune-empty-dirs --ignore-errors --bwlimit=550 --partial --progress --compress --delete-after --fuzzy --archive --hard-links --sparse --xattrs --rsh="ssh -p 22" --exclude-from=$exclude_loc $local_dir $remote_dir

  LAST_EXIT_CODE=$?
  # when rsync was successful=0 or had partial errors=23 we are happy about it - needs revision
  if [ $LAST_EXIT_CODE -eq 0 -o $LAST_EXIT_CODE -eq 23 ]; then
    break
  else
    sleep $TIMEOUT_SECONDS
  fi
done

# check if successful
if [ $LAST_EXIT_CODE -ne 0 -a $LAST_EXIT_CODE -ne 23 ]; then
  echo rsync failed for $I times. giving up. Exit code: $LAST_EXIT_CODE
else
  echo rsync successful after $I times.
  # now let's take a snapshot remotely per ssh command
  ssh -p 22 user@server 'zfs snapshot -r tank@Rsync-`date +%F`'
fi
