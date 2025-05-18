;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.02    ***
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

video_write_service:
    pop     hl

    ld      bc, $BC00
    out     (c), c
    ret