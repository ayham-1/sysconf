#!/bin/bash
# This script is used to control brightness.
# Example:
#     brightness.sh -pinc 10 # Increases brightness by a percentage.
#     brightness.sh -inc 10  # Increases brightness by a value in native units.
#     brightness.sh -pdec 10 # Decreases brightness by a percentage.
#     brightness.sh -dec 10  # Decreases brightness by a value in native units.

set -e
current=$(cat "/sys/class/backlight/intel_backlight/brightness")
max=$(cat "/sys/class/backlight/intel_backlight/max_brightness")

currentPercentage="$(bc <<< "scale=2; $current / $max")" 
currentPercentage=$(echo "$currentPercentage*100" | bc)
new="$current"
newPercentage="$currentPercentage"

if [ "$1" = "-pinc" ]; then
	newPercentage=$(echo "$currentPercentage+$2" | bc)
	new=$(echo "scale=2; $max * ($newPercentage / 100)" | bc)
	currentPercentage=$newPercentage
elif [ "$1" = "-pdec" ]; then
	newPercentage=$(echo "$currentPercentage-$2" | bc)
	new=$(echo "scale=2; $max * ($newPercentage / 100)" | bc)
	currentPercentage=$newPercentage
elif [ "$1" = "-inc" ]; then
    new=$(( current + $2 ))
elif [ "$1" = "-dec" ]; then
    new=$(( current - $2 ))
fi

if [ "${new%.*}" -lt "0" ]; then
	echo "100" | tee "/sys/class/backlight/intel_backlight/brightness"
	echo "1%"
elif [ "${new%.*}" -le "$max" ]; then
	echo "${new%.*}" | tee "/sys/class/backlight/intel_backlight/brightness"
	echo "${currentPercentage}%"
elif [ "${new%.*}" -gt "$max" ]; then
	echo "${max}" | tee "/sys/class/backlight/intel_backlight/brightness"
	echo "100%"
fi
