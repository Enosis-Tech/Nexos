;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech	***
;; *** @file: idt.asm		***
;; *** @date: 16/04/2025	***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

INCLUDE		"firmware/graphics.inc"

;; *********************
;; *** Public labels ***
;; *********************

PUBLIC		IDT
PUBLIC		IDT_FIND_SERVICE

;; ***********************
;; *** Section of code ***
;; ***********************

SECTION		_CODE

;; *************************
;; *** Find BIOS Service ***
;; *************************

;; Formula for calculating the BIOS memory address
;; address = table + (service * length)

;; table	= IDT
;; service	= register A
;; length	= 2

IDT_FIND_SERVICE:
	PUSH	HL			;; Save HL in the stack

	ADD		A, A		;; A * length
	LD		HL, IDT		;; IX = &IDT
	ADD		A, L		;; IDT + SERVICE
	LD		L, A		;; IDT = IDT + SERVICE
	JP		(HL)		;; GOTO (BIOS Service)

;; *********************************
;; *** Section of read only data ***
;; *********************************

SECTION		_RODATA

;; *******************************
;; *** Interruption data table ***
;; *******************************

IDT:
	DEFW	VIDEO_MODE_ZERO
	DEFW	VIDEO_MODE_ONE
	DEFW	VIDEO_MODE_TWO
	DEFW	VIDEO_MODE_THREE