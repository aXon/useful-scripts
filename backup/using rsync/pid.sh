#!/usr/local/bin/bash
#
# Queue the script (you can't match arguments too)
# e.g. 
#	source ./pid.sh --queue
#

# Match script without arguments
LCK_FILE=`basename $0`.lck

# Match script and arguments $@
#LCK_FILE=`basename $0`.`echo "$@" | sed "s/[\/\ \'\"]/_/"`.lck

# Am I Running
if [ -f "${LCK_FILE}" ]; then

  # The file exists so read the PID
  # to see if it is still running
  MYPID=`head -n 1 $LCK_FILE`

  while [ -n "`ps -p ${MYPID} | grep ${MYPID}`" ]
  do
     if [ "$1" == "--queue" ]; then
        #echo "Queuing"
        sleep 1
        MYPID=`head -n 1 $LCK_FILE`
     else
        #echo `basename $0` is already running [$MYPID].
        exit
     fi
  done 
fi

# Echo current PID into lock file
echo "$$" > "$LCK_FILE"
