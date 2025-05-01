;; SPDX-License

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: nexos.asm     ***
;; *** @date: 16/04/2025    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include		"macros/isc.inc"
include		"macros/calc.inc"

;; ***********************
;; *** Kernel services ***
;; ***********************

nexos_service:

;; limit_space $28, $7FFF

syscall_service:
	cp 		 a
	ret 	 m
	ret 	nc
	ret 	nz

	jp		nexos_find_service


;; limit_space $40, $7FFF

;; *********************
;; *** Find services ***
;; *********************

nexos_find_service:
	push	hl

	add		a
	ld		hl, (nexos_idt - nexos_find_service) + $28
	
	add		l
	ld		l, a
	
	jp		(hl)

;; ***************************
;; *** Iterrupt Data Table ***
;; ***************************

nexos_idt:

	;; unistd process

	sysaddr $00, $3C
	sysaddr $01, $3C
	sysaddr $02, $3C
	sysaddr $03, $3C
	sysaddr $04, $3C

	;; unistd memory

	sysaddr $05, $3C
	sysaddr $06, $3C

	;; signals

	sysaddr $07, $3C
	sysaddr $08, $3C
	sysaddr $09, $3C
	sysaddr $0A, $3C

	;; time

	sysaddr $0B, $3C
	sysaddr $0C, $3C

;; *******************
;; *** Kernel main ***
;; *******************

nexos_main:
	ret