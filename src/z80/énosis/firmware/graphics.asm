;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: graphics.asm	***
;; *** @date: 16/04/2025	***
;; ****************************

;; *************************
;; *** Set public labels ***
;; *************************

PUBLIC		VIDEO_MODE_ZERO
PUBLIC		VIDEO_MODE_ONE
PUBLIC		VIDEO_MODE_TWO
PUBLIC		VIDEO_MODE_THREE

;; *************************************
;; *** Servicios gráficos de la BIOS ***
;; *************************************

SECTION		_CODE

VIDEO_MODE_ZERO:
	POP		HL
	
	LD		BC, $BC00
	OUT		(C), C
	RETI

VIDEO_MODE_ONE:
	POP		HL
	
	LD		BC, $BC00
	OUT		(C), C
	RETI

VIDEO_MODE_TWO:
	POP		HL

	LD		BC, $BC00
	OUT		(C), C
	RETI

VIDEO_MODE_THREE:
	POP		HL

	LD		BC, $BC00
	OUT		(C), C
	RETI