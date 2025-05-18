;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech	***
;; *** @version 00.00.01	***
;; ****************************

;; *********************************
;; *** Avoid file re-definitions ***
;; *********************************

ifndef __STRUCTS_INC__
define __STRUCTS_INC__

macro PCB name
	name:
		defb $00	;; PID
		defb $00	;; State
		defb $00	;; Priority
		defb $00	;; Page
		defb $00	;; ticks_left
		defw $00	;; Program Counter
		defw $00	;; Stack pointer
		defs $0C	;; Space for registers	
endm

endif