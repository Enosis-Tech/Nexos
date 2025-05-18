;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include     "macros/stdreg.inc"

;; **************************************
;; *** Exclusive equats for this file ***
;; **************************************

STD_INITIAL_ADDRESS equ $C0 ;; Bank 3

;; *******************
;; *** Init system ***
;; *******************

start:
    
    di  ;; Diable interruption for secure execution

    ;; Set bank 3

    ld      a, $10  ;;
    out0    (CBR), a            ;;

    ld      a, $10    ;;
    out0    (BBR), a            ;;

    xor      a              ;;
    out0    (BBR), a    ;;