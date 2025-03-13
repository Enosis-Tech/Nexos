#!/bin/sh

. /etc/os-release

DISTRO=$ID

case "$DISTRO" in

	debian|ubuntu)
		
		sudo apt update
		sudo apt install fasm -y
		;;
	
	arch)
		
		sudo pacman -Syu
		sudo pacman -S fasm
		;;

	fedora)
		
		sudo dnf update
		sudo dnf install fasm -y
		;;

	*)
		
		echo "Distro no soportada"
		exit 1
		;;

esac