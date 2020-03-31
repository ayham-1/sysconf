#!/bin/bash

function install() {
	cd "$1"
	make -j5 clean install
	make clean
	cd ..
}

function install_config() {
	rsync -a dotfiles/$1/ $HOME/
}

# Install dmenu
install "dmenu"
install "dwm"
install "slock"
install "st"

# Install configuration files.
install_config "emacs"
install_config "git"
install_config "tmux"
install_config "neovim"
