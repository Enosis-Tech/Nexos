;; SPDX-License

;; ****************************
;; *** @author: Έnosis Tech	***
;; *** @file: mmu.inc		***
;; *** @date: 16/04/2025	***
;; ****************************

;; *********************************
;; *** Avoid file re-definitions ***
;; *********************************

IFNDEF __MMU_INC__
__MMU_INC__ equ 1

;; ********************
;; *** MMU register ***
;; ********************

MMU_CBR		equ $38
MMU_BBR		equ $39
MMU_CBAR	equ $3A

;; *************************
;; *** MMU standar banks ***
;; *************************

STD_MMU_BBR_BANK1	equ $00	;; Memory bank 0
STD_MMU_BBR_BANK2	equ $00	;; Memory bank 1
STD_MMU_BBR_BANK3	equ $00	;; Memory bank 2
STD_MMU_BBR_BANK4	equ $00	;; Memory bank 3

ENDIF