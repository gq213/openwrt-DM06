#!/bin/sh

. /lib/ramips.sh

board=$(ramips_board_name)

if [ "$board"x != "widora"x ]; then
	echo "board type error!"
	return 0
fi

uci set wireless.sta.disabled='1'

uci set network.wan=interface
uci set network.wan.ifname='eth0.1'
uci set network.wan.proto='dhcp'

uci set network.lan=interface
uci set network.lan.ifname='eth0.2'
uci set network.lan.type='bridge'
uci set network.lan.proto='static'
uci set network.lan.ipaddr='192.168.100.1'
uci set network.lan.netmask='255.255.255.0'

uci commit
return 0
