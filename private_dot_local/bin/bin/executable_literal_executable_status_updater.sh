#!/bin/bash

for pid in $(pidof -x "status_updater.sh"); do
    if [ $pid != $$ ]; then
        echo "$(date +"%F %T"): status_updater.sh is already running with PID $pid, killing"
        kill $pid
    fi
done

wait_for_ipc_handler () {
	seconds=$1

	for (( d=1; d<=2*${seconds}; d++ ))
	do
		sleep 0.5
		duskc --ignore-reply get_monitors 2>/dev/null 1>&2
		if [ $? = 0 ]; then
			return
		fi
	done

	echo "Failed to reach IPC handler, bailing"
	exit
}

# Add an artificial sleep to wait for the IPC handler to be ready to process requests
sleep 0.5

SETSTATUS="duskc --ignore-reply run_command setstatus"

# $SETSTATUS 7 "$(~/bin/statusbar/statusbutton)" &

secs=0
while true; do

  $SETSTATUS 0 "$(~/.local/bin/statusbar/clock.sh)" &

  if [ $? != 0 ]; then
		wait_for_ipc_handler 30
	fi
  if [ $((secs % 5)) = 0 ]; then
    $SETSTATUS 2 "$(~/.local/bin/statusbar/volume.sh)" &
  fi

  if [ $((secs % 15)) = 0 ]; then
    $SETSTATUS 3 "$(~/.local/bin/statusbar/temp.sh)" &
    $SETSTATUS 4 "$(~/.local/bin/statusbar/load.sh)" &
  fi

  if [ $((secs % 60)) = 0 ]; then
    $SETSTATUS 1 "$(~/.local/bin/statusbar/battery.sh)" &
	fi

	# Update these once after 1 minute, i.e. hourly
	# if [ $secs = 60 ]; then
		# $SETSTATUS 4 "$($DIR/sysupdates)" &
		# $SETSTATUS 7 "$($DIR/statusbutton)" &
	# fi

	# Restart script every hour
	if [ $secs = 3600 ]; then
		exec ${BASH_SOURCE[0]}
	fi

    ((secs+=1))
    sleep 1
done
