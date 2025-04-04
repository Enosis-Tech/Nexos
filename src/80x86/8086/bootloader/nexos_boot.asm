;; SPDX-License: GPL-2

;; ***************************************************
;; *** The simple binary for the BIOS and 8086 CPU ***
;; ***************************************************

format binary

;; ************************
;; *** Set the able ISC ***
;; ************************

use16

;; ************************************************
;; *** Import macros and structures for the use ***
;; ************************************************

include "include/80x86/8086/boot/bios.inc"
include "include/80x86/8086/boot/fat.inc"

;; **************************************************
;; *** BIOS read initialize at 7C00 in the memory ***
;; **************************************************

org $7C00

;; ***********************************
;; *** Jumpt to start boot manager ***
;; ***********************************

jmp		boot
nop

;; *********************************
;; *** Configure from tabe FAT12 ***
;; *********************************

fat FAT12 $001, $0E0, "MOS FLOPPY "	;; Sector per cluster, root entries, volume label (11 bytes)

;; *********************************************
;; *** Start to load from nexos boot manager ***
;; *********************************************

boot:
	
	cli
	mov		ax, $7BF
	mov		ss, ax
	mov		sp, $0F	
	sti

	xor		ah, ah
	mov		al, $03
	int		$10

;; ********************************
;; *** Print message of loading ***
;; ********************************

	lea		di, [msg.system]
	mov		si, msg.system.length
	call	puts

;; ***********************
;; *** Reset unit disk ***
;; ***********************

.reset:
	xor		ah, ah
	xor		dl, dl
	int		$13
	jc		.reset

	lea		di, [msg.system]
	mov		si, msg.system.length
	call	puts

;; ******************************
;; *** Set ES:BX for the jump ***
;; ******************************

	mov		dx, di
	mov		cx, si
	mov		ax, $7E0

;; ******************
;; *** Start read ***
;; ******************

.read:
	mov		ax, $7E0
	mov		es, ax
	xor		bx, bx

	mov		ah, 2	;; Number of service BIOS
	mov		al, 8	;; NUmber of sectors to read (depende the version)
	
	ld		ch, 1	;; One cylinder
	mov		cl, 2	;; Two sectors
	
	ld		dh, 0	;; ZERO
	ld		dl, $80	;; Floppy disk
	
	int		$13		;; Call BIOS Service
	jc		.read	;; Repet the lecture if fail

;; *************************
;; *** Load second stage ***
;; *************************

.done:
	
	lea		di, [msg.system]
	mov		si, msg.system.length
	call	puts

	jmp		far dword DIR_SECOND_SECTOR : BUFFER_TO_READ_SECTOR

;; ******************************
;; *** Read sectors subrutine ***
;; ******************************

bios_read:
	mov		dx, di
	mov		cx, si
	mov		ax, $7E0
	mov		es, ax
	xor		bx, bx
	mov		ax, $0208
	int		$13
	jc		bios_read
	ret

;; *************
;; *** Print ***
;; *************

puts:
	test	si, si
	jz		.done

	mov		al, byte [di]
	mov		ah, $0E
	int		$10

	inc		di
	dec		si

	jmp		puts

.done:
	ret

;; *******************
;; *** Information ***
;; *******************

msg:
	.system: db "Loading Nexos Operating System", $0D, $0A
	.system.length = $ - .system

;; **********************************
;; *** Length the sector and firm ***
;; **********************************

times $1FE - ($ - $$) db $00
dw $AA55

org $7E00

main_boot:
	
	cli
	push	cs
	pop		ds

	lea		di, [msg.two]
	mov		si, msg.two.length
	call	write

;;	mov ah, 0x00       ; Función: Establecer modo de video
;;	mov al, 0x03       ; Modo 3: 80x25 texto con 16 colores
;;	int 0x10           ; Llamada a la BIOS

	cli
	hlt

	jmp $

;; ***********************************
;; *** Microkernel POSIX interface ***
;; ***********************************

write:
	test	si, si
	jz		.done

	mov		al, byte [di]
	mov		ah, $0E
	int		$10

	inc		di
	dec		si

	jmp		write

.done:
	ret

;; ****************************
;; *** Priority from sector ***
;; ****************************

firm:	dw $A13B	;; Sector de máxima prioridad en el que se leen 3B/59 sectores BIOS

;; *********************
;; *** Debug message ***
;; *********************

msg.two: db "Hello World"
msg.two.length = $ - msg.two

times $1000 - ($ - $7E00) db $00