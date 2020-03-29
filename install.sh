#!/bin/bash

destdir="$1"
echo "Installing in to: $1"
export DESTDIR=$(destdir)

function install() {
	cd "$1"
	make -j5 clean install
	cd ..
}

# Install dmenu
install "dmenu"
install "dwm"
install "slock"
install "st"
install "surf"
