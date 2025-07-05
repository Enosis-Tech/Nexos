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
;; *** Global labels ***
;; *********************

global		bootloader

;; ******************
;; *** Bootloader ***
;; ******************

	bootloader:
		di	;; Dissable interrupts
		
		xor		a
		ld		a, mb
		or		EADL
		ld		mb, a
	
		ei	;; Enable interrupts