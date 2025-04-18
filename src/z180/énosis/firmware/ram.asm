;; SPDX-License

;; ****************************
;; *** @author: Έnosis Tech	***
;; *** @file: ram.asm		***
;; *** @date: 16/04/2025	***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

;; ****************************
;; *** Load firmware at ram ***
;; ****************************

load_ram_firmware:

	;; Setting the framework

	ld		hl, $10		;; Base dir value (hl = &0x10)
	ld		de, $10		;; Base dir copy value (*de = *hl)
	ld		bc, $48		;; Counter

load_ram_firmware_loop:
	
	;; Repeat instruction 16 times

	rept	$10
		
		;; If bc != 0 continue
		;; hl is the pointer to memory addres
		;; copy value to memory addrees pointer
		;; at the de register

		ldir
	
	endr

	;; Ensures that all values
	;; are completely copied
	;; to the ram memory

	;; if b != 0 and c != 0, repeat until zero

	ld		a, b
	tst		c
	jr		nz, load_ram_firmware_loop

;; ******************************
;; *** Load bootloader at ram ***
;; ******************************

load_ram_bootloader:

	;; Setting the framework

	ld		hl, boot
	ld		de, boot
	ld		bc, $1000

load_ram_bootloader_loop:

	rept	$10
		ldir
	endr

	ld		a, b
	tst		c
	jr		nz, load_ram_bootloader_loop

load_ram_end:
	jp		boot