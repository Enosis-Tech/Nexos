#!/bin/sh

. /etc/os-release

DISTRO=$ID

case "$DISTRO" in

	debian|ubuntu)
		
		sudo apt update
		sudo apt install mtools -y
		;;
	
	arch)
		
		sudo pacman -Syu
		sudo pacman -S mtools
		;;

	fedora)
		
		sudo dnf update
		sudo dnf install mtools -y
		;;

	*)
		
		echo "Distro no soportada"
		exit 1
		;;

esac