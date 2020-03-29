#!/bin/bash

function install() {
	cd "$1"
	make -j5 clean install
	make clean
	cd ..
}

# Install dmenu
install "dmenu"
install "dwm"
install "slock"
install "st"
install "surf"
