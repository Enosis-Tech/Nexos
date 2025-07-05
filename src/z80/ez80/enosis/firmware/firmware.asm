;; SPDX-License-identifier: LGPL-3

;; **********************************
;; *** @author  Enosis Technology ***
;; *** @version 00.00.01		  ***
;; **********************************

;; **********************
;; *** Origin address ***
;; **********************

org			000050h

;; ********************
;; *** Import files ***
;; ********************

include		"../include/aliases.inc"

;; *********************
;; *** Global labels ***
;; *********************

global		firmware

;; ********************
;; *** Section code ***
;; ********************

section code

	firmware:
		ld		a, 10h
		slp