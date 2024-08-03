#!/bin/bash
COLOR=^c#FFF7D4^
PREFIX=' '
TIME="$(date +'%H:%M')"

case $BLOCK_BUTTON in
	1) notify-send -t 3000 "$(date '+%A')" "📅 $(date '+%B %dXX' | sed -r -e 's/(1[123])XX/\1th/;s/1XX/1st/;s/2XX/2nd/;s/3XX/3rd/;s/XX/th/;s/ 0/ /')" & ;;
	2) st -t "Calendar" -e bash -c "cal -y; read  -n 1 -p '' ignored" & ;;
	3) notify-send -t 9000 "$(date '+%A')" "$(cal --color=never)" & ;;
	*) echo "${COLOR}${PREFIX}${TIME}^d^" ;;
esac
