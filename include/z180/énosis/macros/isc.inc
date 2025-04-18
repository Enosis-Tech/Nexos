;; SPDX-License

;; ****************************
;; *** @author: Έnosis Tech	***
;; *** @file: idt.inc		***
;; *** @date: 16/04/2025	***
;; ****************************

;; *********************************
;; *** Avoid file re-definitions ***
;; *********************************

IFNDEF __ISC_INC__
__ISC_INC__ equ 1

macro pushall
	push	af
	push	bc
	push	de
	push	hl
	push	ix
	push	iy
	push	sp
endm

macro popall
	pop		af
	pop		bc
	pop		de
	pop		hl
	pop		ix
	pop		iy
	pop		sp
endm

ENDIF