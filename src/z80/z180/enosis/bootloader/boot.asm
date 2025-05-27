;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.03       ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include     "firmware/idt.inc"

;; ******************
;; *** Bootloader ***
;; ******************

boot:
    xor     A       ;; Seleccionar la configuración
    ld      L, $01  ;; Modo texto
    rst     $10     ;; Llamar a la BIOS

loop:
    jr      loop

;; defs     $1FFE - ($ - $07C0) ;; 510 bytes
defw        $EB1D               ;; Firma digital