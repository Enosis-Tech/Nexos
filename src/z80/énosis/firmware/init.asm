;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: init.asm	***
;; *** @date: 16/04/2025	***
;; ****************************

;; **********************
;; *** Origin address ***
;; **********************

ORG			$0000

;; ********************
;; *** Import files ***
;; ********************

INCLUDE		"firmware/idt.inc"
INCLUDE		"firmware/graphics.inc"
INCLUDE		"bootloader/boot.inc"

;; *************************
;; *** Set public labels ***
;; *************************

PUBLIC		init_main

;; ***********************
;; *** Section of code ***
;; ***********************

SECTION		_CODE

init_main:
	
	XOR		A
	LD		BC, $0000
	LD		DE, $0000
	LD		HL, $0000
	LD		SP, $BFFF
	JP		boot

defs	$10 - ($ - $00)

;; *******************
;; *** RST Service ***
;; *******************

;; Verify that the BIOS service exists
;; before proceeding with the search.
	
	CP		$0A		;; Set flags
	RET		M		;; If the sign is set, it is an error
	RET		NC		;; If A > 10, it is an error
	RET		NZ		;; If A != 0, it is an error
	
	JP		IDT_FIND_SERVICE ;; Jump to the subrutine of search

limit_rst_10: defs	$08 - ($ - $10) ;; Space limit of rst $10

;; **************************
;; *** Limit space of rst ***
;; **************************

limit: defs	$48 - ($ - $00)