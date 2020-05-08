#!/bin/bash
# This script is used for the systray on dwm.
# Example:
#    (DE start command) & statusbar.sh

SEPERATOR=" | "
STATUS=""

function getDate() {
	date="$(date +"%D %T")"
}

function getBattery() {
	ACPI="/sys/class/power_supply/BAT0"

	capacityNow="$(cat $ACPI/capacity)"
	capacityLevel="$(cat $ACPI/capacity_level)"

	chargeMax="$(cat $ACPI/charge_full_design)"
	chargeNow="$(cat $ACPI/charge_now)"

	voltageNow="$(cat $ACPI/voltage_now)"
	voltageMin="$(cat $ACPI/voltage_min_design)"
	
	status="$(cat $ACPI/status)"
	if [ $status == "Charging" ]; then 
		status="+"
	else 
		status="-" 
	fi
	
	battery="${capacityNow}%${status}"
}

function getWIFI() {
	wifi="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
}

function getBrightness() {
	brightness=$(xbacklight)
	brightness=${brightness%.*}
}

function getVolume() {
	volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
}

while true; do
	getDate
	getBattery
	getWIFI
	getBrightness
	getVolume
	
	STATUS="${date}${SEPERATOR}${battery}${SEPERATOR}${brightness}%${SEPERATOR}${volume}%${SEPERATOR}${wifi}"
	xsetroot -name "$STATUS"
	sleep 1s
done
