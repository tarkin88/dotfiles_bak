#!/bin/bash

# Prints out the volume percentage

VOLUME_ON_ICON=''
VOLUME_MUTED_ICON=''
COLOR=^c#FFF7D4^

get_volume(){
        curStatus=$(pactl get-sink-mute @DEFAULT_SINK@)
        volume=$(pactl get-sink-volume @DEFAULT_SINK@ | tail -n 2 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' | head -n 1)

        if [ "${curStatus}" = 'Mute: yes' ]
        then
            echo "$VOLUME_MUTED_ICON  $volume%"
        else
            echo "$VOLUME_ON_ICON  $volume%"
        fi
}


case $BLOCK_BUTTON in
  *) echo "${COLOR}$(get_volume)^d^" ;;
esac


