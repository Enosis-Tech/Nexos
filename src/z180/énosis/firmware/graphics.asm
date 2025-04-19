;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: graphics.asm  ***
;; *** @date: 16/04/2025    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include     "firmware/idt.inc"

;; *************************************
;; *** Servicios gráficos de la BIOS ***
;; *************************************

video_mode_zero:
    pop     hl
    
    ld      bc, $BC00
    out     (c), c
    ret

video_mode_one:
    pop     hl
    
    ld      bc, $BC00
    out     (c), c
    ret

video_mode_two:
    pop     hl

    ld      bc, $BC00
    out     (c), c
    ret

video_mode_three:
    pop     hl

    ld      bc, $BC00
    out     (c), c
    ret