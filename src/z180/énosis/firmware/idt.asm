;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech	***
;; *** @file: idt.asm		***
;; *** @date: 16/04/2025	***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include		"firmware/graphics.inc"

;; *************************
;; *** Find BIOS Service ***
;; *************************

;; Formula for calculating the BIOS memory address
;; address = table + (service * length)

;; table	= IDT
;; service	= register A
;; length	= 2

idt_find_service:
	
	push	hl			;; Save HL in the stack

	add		a			;; A * length
	ld		hl, idt		;; IX = &IDT
	add		l			;; IDT + SERVICE
	ld		l, a		;; IDT = IDT + SERVICE
	jp		(hl)		;; GOTO (BIOS Service)

;; *********************************
;; *** Section of read only data ***
;; *********************************


;; *******************************
;; *** Interruption data table ***
;; *******************************

idt:
	defw	video_mode_zero
	defw	video_mode_one
	defw	video_mode_two
	defw	video_mode_three

limit_idt: defs	$D0 - ($ - idt)