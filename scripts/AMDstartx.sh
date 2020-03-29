#!/bin/bash
# This script is used to start XORG server with dedicated graphics (hyprid).
# NOTE: RESTART BEFORE SWITCHING DRI_PRIME value
# Example:
#     AMDstartx.sh

DRI_PRIME=1 startx
