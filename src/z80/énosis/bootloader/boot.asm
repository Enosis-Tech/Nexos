;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: init.asm	***
;; *** @date: 16/04/2025	***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

INCLUDE		"firmware/idt.inc"

;; *************************
;; *** Set public labels ***
;; *************************

PUBLIC		boot

;; ******************************
;; *** Bootloader del sistema ***
;; ******************************

boot:
	XOR		A		;; Seleccionar la configuración
	LD		L, $01	;; Modo texto
	RST		$10		;; Llamar a la BIOS

;; DEFS		$1FFE - ($ - $07C0)	;; 510 bytes
;; DEFW		$EB1D				;; Firma digital