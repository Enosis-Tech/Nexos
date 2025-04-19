;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: nexos_mk.asm  ***
;; *** @date: 19/04/2025    ***
;; ****************************

;; ***************************************************
;; *** The simple binary for the BIOS and 8086 CPU ***
;; ***************************************************

format binary

;; ************************
;; *** Set the able ISC ***
;; ************************

use16

;; ************************************************
;; *** Import macros and structures for the use ***
;; ************************************************

include "include/80x86/8086/boot/bios.inc"
include "include/80x86/8086/boot/fat.inc"

;; *******************************************
;; *** Boot operating system (development) ***
;; *******************************************

org $600

main_boot:
    
    cli
    push    cs
    pop     ds

    lea     di, [msg.two]
    mov     si, msg.two.length
    call    write

    mov ah, 0x00       ; Función: Establecer modo de video
    mov al, 0x03       ; Modo 3: 80x25 texto con 16 colores
    int 0x10           ; Llamada a la BIOS

    cli
    hlt

    jmp $

;; ***********************************
;; *** Microkernel POSIX interface ***
;; ***********************************

write:
    test    si, si
    jz      .done

    mov     al, byte [di]
    mov     ah, $0E
    int     $10

    inc     di
    dec     si

    jmp     write

.done:
    ret

;; ****************************
;; *** Priority from sector ***
;; ****************************

firm:   dw $A13B    ;; Sector de máxima prioridad en el que se leen 3B/59 sectores BIOS

;; *********************
;; *** Debug message ***
;; *********************

msg:
    .two: db "Hello World"
    .two.length = $ - msg.two


times ($7C00 - $600) - ($ - $600) db $00