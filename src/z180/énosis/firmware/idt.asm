;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: idt.asm       ***
;; *** @date: 16/04/2025    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include     "firmware/graphics.inc"

;; *************************
;; *** Find BIOS Service ***
;; *************************

;; Formula for calculating the BIOS memory address
;; address = table + (service * length)

;; table    = IDT
;; service  = register A
;; length   = 2

idt_find_service:
    
    push    hl          ;; Save HL in the stack

    add     a           ;; A * length
    ld      hl, idt     ;; HL = &IDT
    add     l           ;; IDT + SERVICE
    ld      l, a        ;; IDT = IDT + SERVICE
    jp      (hl)        ;; GOTO (BIOS Service)

;; *********************************
;; *** Section of read only data ***
;; *********************************


;; *******************************
;; *** Interruption data table ***
;; *******************************

idt:
    ;; System option
    defw    system_reboot

    ;; Video options

    defw    video_mode_zero
    defw    video_mode_one
    defw    video_mode_two
    defw    video_mode_three
    defw    video_write_service

    ;; Security option

    defw    secure_number

    defs $28 - ($ - idt)

limit_idt: defs $30 - ($ - idt)