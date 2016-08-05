#!/bin/sh

. /lib/ramips.sh

enable=$1
ssid=$2
key=$3
enc=$4

board=$(ramips_board_name)

if [ "$board"x = "dm06"x ]; then

	if [ "$enable"x = "0"x ]; then
		echo "disable sta!"
		uci set wireless.sta.disabled='1'
	else
		echo "enable sta!"
		uci set wireless.sta.disabled='0'
	fi

fi

uci set wireless.sta.ssid=$ssid
uci set wireless.sta.key=$key
uci set wireless.sta.encryption=$enc

uci commit
return 0
