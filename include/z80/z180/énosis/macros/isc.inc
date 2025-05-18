;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech	***
;; *** @file: isc.inc		***
;; *** @date: 16/04/2025	***
;; ****************************

;; *********************************
;; *** Avoid file re-definitions ***
;; *********************************

ifndef __ISC_INC__
define __ISC_INC__

macro pushall
	push	af
	push	bc
	push	de
	push	hl
	push	ix
	push	iy
endm

macro popall
	pop		iy
	pop		ix
	pop		hl
	pop		de
	pop		bc
	pop		af
endm

endif