#!/bin/sh

. /etc/os-release

DISTRO=$ID

case "$DISTRO" in

	debian|ubuntu)
		
		sudo apt update
		sudo apt install qemu-system qemu-static-user -y
		;;
	
	arch)
		
		sudo pacman -Syu
		sudo pacman -S qemu
		;;

	fedora)
		
		sudo dnf update
		sudo dnf install @virtualization -y
		;;

	*)
		
		echo "Distro no soportada"
		exit 1
		;;

esac