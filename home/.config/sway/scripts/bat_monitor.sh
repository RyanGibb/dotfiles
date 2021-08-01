#!/bin/sh

while :
do
	acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
		read -r status capacity
	
		if [ "$status" = Discharging -a "$capacity" -lt 5 ]; then
			logger "Critical battery threshold"
			systemctl hibernate
		elif [ "$status" = Discharging -a "$capacity" -lt 15 ]; then
			notify-send "warning: battery at $capacity%"	
		fi
	}
	sleep 60
done

