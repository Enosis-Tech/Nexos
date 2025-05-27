;; SPDX-License-identifier: LGPL-3

;; **********************************
;; *** @author  Enosis Technology ***
;; *** @version 00.00.01		  ***
;; **********************************

;; **********************
;; *** Origin address ***
;; **********************

org			000000h

;; ********************
;; *** Import files ***
;; ********************

include		"../include/aliases.inc"

;; *********************
;; *** Extern labels ***
;; *********************

extern		firmware

;; ********************
;; *** Section code ***
;; ********************

section code

	init:
		ld		hl, firmware
		ld		de, 0000h
		ld		bc, 01FFh
		ldir