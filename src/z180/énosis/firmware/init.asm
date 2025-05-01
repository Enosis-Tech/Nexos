;; SPDX-License

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: ram.asm       ***
;; *** @date: 16/04/2025    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include     "firmware/mmu.inc"
include     "firmware/dma.inc"

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

    ld      a, STD_INITIAL_ADDRESS  ;;
    out0    (MMU_CBR), a            ;;

    ld      a, STD_MMU_BBR_BANK3    ;;
    out0    (MMU_BBR), a            ;;

    xor      a              ;;
    out0    (MMU_BBR), a    ;;