#!/bin/sh

. /etc/os-release

DISTRO=$ID

case "$DISTRO" in

	debian|ubuntu)
		
		sudo apt update
		sudo apt install grub2 -y
		;;
	
	arch)
		
		sudo pacman -Syu
		sudo pacman -S grub
		;;

	fedora)
		
		sudo dnf update
		sudo dnf install grub2 -y
		;;

	*)
		
		echo "Distro no soportada"
		exit 1
		;;

esac