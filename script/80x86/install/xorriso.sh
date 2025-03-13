#!/bin/sh

. /etc/os-release

DISTRO=$ID

case "$DISTRO" in

	debian|ubuntu)
		
		sudo apt update
		sudo apt install xorriso -y
		;;
	
	arch)
		
		sudo pacman -Syu
		sudo pacman -S xorriso
		;;

	fedora)
		
		sudo dnf update
		sudo dnf install xorriso -y
		;;

	*)
		
		echo "Distro no soportada"
		exit 1
		;;

esac