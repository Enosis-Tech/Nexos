;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.02    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include     "firmware/idt.inc"
include     "firmware/graphics.inc"
include     "bootloader/boot.inc"

;; ******************************
;; *** Load secure bootloader ***
;; ******************************

start_firm:
    
    di              ;; Disable interruptions
    xor     a       ;; Clear a register (a = 0)
    
    ;; Clear registers hl, bc and de

    ld      b, a
    ld      c, a
    
    ld      d, a
    ld      e, a
    
    ld      h, a
    ld      l, a
    
    ;; Secure load system

    ld      a, $3A  ;; A = #3A
    cp      $3A     ;; Set flags

    jp      z, $2000 ;;  Jump if A == #3A, is secure

    xor     a   ;; Secure execution of #10 memory address

limit_rst_00: defs  $10 - ($ - start_firm) ;; Space limit of rst $00

;; *******************
;; *** RST Service ***
;; *******************

;; Verify that the BIOS service exists
;; before proceeding with the search.

bios_service:

    cp      $14     ;; Set flags
    ret     m       ;; If the sign is set, it is an error
    ret     nc      ;; If A > 10, it is an error
    ret     nz      ;; If A != 0, it is an error
    
    jr      idt_find_service ;; Jump to the subrutine of search

limit_rst_10: defs  $08 - ($ - bios_service) ;; Space limit of rst $10

;; *******************
;; *** Limit space ***
;; *******************

limit_service: defs $48 - ($ - start_firm)