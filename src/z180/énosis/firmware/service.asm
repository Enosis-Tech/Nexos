;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: 	service.asm	***
;; *** @date: 16/04/2025	***
;; ****************************

;; **********************
;; *** Origin address ***
;; **********************

org			$0000

;; ********************
;; *** Import files ***
;; ********************

include		"firmware/idt.inc"
include		"firmware/graphics.inc"
include		"bootloader/boot.inc"

;; ******************************
;; *** Load secure bootloader ***
;; ******************************

start_system:
	
	xor		a
	ld		bc, $0000
	ld		de, $0000
	ld		hl, $0000
	ld		sp, $BFFF
	jp		load_ram_firmware

limit_rst_00: defs	$10 - ($ - $00) ;; Space limit of rst $00

;; *******************
;; *** RST Service ***
;; *******************

;; Verify that the BIOS service exists
;; before proceeding with the search.

bios_service:

	cp		$0A		;; Set flags
	ret		m		;; If the sign is set, it is an error
	ret		nc		;; If A > 10, it is an error
	ret		nz		;; If A != 0, it is an error
	
	jp		idt_find_service ;; Jump to the subrutine of search

limit_rst_10: defs	$08 - ($ - $10) ;; Space limit of rst $10

;; *******************
;; *** Limit space ***
;; *******************

limit_service: defs $48 - ($ - $00)