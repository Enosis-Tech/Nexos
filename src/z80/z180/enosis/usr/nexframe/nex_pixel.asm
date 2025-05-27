;;;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01    ***
;; ****************************

;; *********************
;; *** Include files ***
;; *********************

include "usr/nextframe/ra8875.inc"

;; ***********************
;; *** Section of code ***
;; ***********************

;; This subrutine print a pixel

section _CODE

nex_pixel:
	push	bc
	
	pop		bc
	ret