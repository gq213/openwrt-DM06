#!/bin/sh

NAME="$(uci get wireless.ap.ssid)"
echo "start dlna daemon ($NAME)" > /dev/console
FileMediaServerTest -f "$NAME-DMS" /tmp &
MediaRendererTest -f "$NAME-L" &

while true
do
        #echo "check"
               
        if [ -f "/tmp/DmrStart" ]; then
                echo "daemon, start dlna..."
                MediaRendererTest -f "$NAME-W" &
                rm -rf /tmp/DmrStart
        fi     
               
        sleep 3
done
