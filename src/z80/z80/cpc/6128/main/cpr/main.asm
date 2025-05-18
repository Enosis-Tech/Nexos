BUILDCPR
BANK #0000

INCLUDE "macros/isc.inc"

ORG		#0000
RUN		START

;;*********************

REBOOT

	JP		START		;; Load bootloader

;; ********************
;; *** Servicio RST ***
;, ********************

ORG			#10

RST_BIOS
	JP		BIOS_SEARCH_SERVICE


;; ***********************************
;; *** Fuera de las interrupciones ***
;; ***********************************

ORG			#40

;; *******************************************
;; *** Tablas de interrupciones de la BIOS ***
;; *******************************************

IDT
	DEFW	VIDEO_MODE_ZERO
	DEFW	VIDEO_MODE_ONE
	DEFW	VIDEO_MODE_TWO
	DEFW	VIDEO_MODE_THREE

;; *****************************
;; *** BIOS search services ***
;; *****************************

BIOS_SEARCH_SERVICE
	ADD		A, A
	LD		IX, IDT
	ADD		A, IXL
	LD		IXL, A
	JP		(IX)

;; ****************************
;; *** Servicios de la BIOS ***
;; ****************************

VIDEO_MODE_ZERO
	LD		BC, #BC00
	OUT		(C), C
	RETI

VIDEO_MODE_ONE
	LD		BC, #BC00
	OUT		(C), C
	RETI

VIDEO_MODE_TWO
	LD		BC, #BC00
	OUT		(C), C
	RETI

VIDEO_MODE_THREE
	LD		BC, #BC00
	OUT		(C), C
	RETI

;; ******************************
;; *** Bootloader del sistema ***
;; ******************************

ORG			#07C0

START
	XOR		A		;; Seleccionar la configuración
	LD		L, #01	;; Modo texto
	RST		#10		;; Llamar a la BIOS

DEFS		#01FE - ($ - #07C0)	;; 510 bytes
DEFW		#AA55				;; Firma digital