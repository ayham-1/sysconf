#!/bin/bash
# This script is used to control machine state.
# Includes commands for suspending to RAM.
# Includes commands for powering off.
# Genkernel initramfs prevents suspending to disk. (Check this if needed).
# Example:
#    power off # Turns off the machine.
#    power suspend # Suspend machine to RAM

if [ "$1" == "off" ]; then
	shutdown -a now
elif [ "$1" == "suspend" ]; then
	echo mem > /sys/power/state
fi
