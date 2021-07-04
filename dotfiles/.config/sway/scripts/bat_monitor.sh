#!/bin/sh

while :
do
	acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
		read -r status capacity
	
		if [ "$status" = Discharging -a "$capacity" -lt 15 ]; then
			notify-send "warning: battery at $capacity%"	
		fi
		if [ "$status" = Discharging -a "$capacity" -lt 5 ]; then
			logger "Critical battery threshold"
			systemctl suspend-then-hibernate
		fi
		if [ "$status" = Discharging -a "$capacity" -lt 3 ]; then
			logger "Critical battery threshold"
			systemctl hibernate
		fi
	}
	sleep 60
done

