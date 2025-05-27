;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01	***
;; ****************************

;; **********************
;; *** Origin address ***
;; **********************

org         $2000

;; ************************
;; *** Import libraries ***
;; ************************

include		"macros/calc.inc"

;; ******************
;; *** Bootloader ***
;; ******************

include     "bootloader/boot.asm"

limit_space $2000, $2000