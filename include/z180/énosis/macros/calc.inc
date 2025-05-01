;; SPDX-License

;; ****************************
;; *** @author: Έnosis Tech	***
;; *** @file: calc.inc		***
;; *** @date: 16/04/2025	***
;; ****************************

;; *********************************
;; *** Avoid file re-definitions ***
;; *********************************

IFNDEF __CALC_INC__
__CALC_INC__ equ 1

;; current = $
;; space = n
;; limit = n

macro limit_space space, limit
	
	defs	space - ($ - limit)

endm

;; Base dir = 40
;; Sysc num = n
;; space    = 60

macro sysaddr syscall_number, syscall_space
	
	defw	(syscall_number * syscall_space) + $28

endm

;; base label  =
;; obje label  = 
;; addr physic =

macro calc_addr base_label, obje_label, addr_physic

	(obje_label - base_label) + addr_physic

endm

ENDIF