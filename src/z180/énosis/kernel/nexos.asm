;; SPDX-License

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.04    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include     "macros/isc.inc"
include     "macros/calc.inc"

;; ***********************
;; *** Kernel services ***
;; ***********************

syscall_service:
    cp       a
    ret      m
    ret     nc
    ret     nz

    jp      nexos_find_service

limit_space $40, $00

;; ****************************
;; *** Interrupt data tabla ***
;; ****************************

nexos_idt:
    ret

;; *********************
;; *** Find services ***
;; *********************

nexos_find_service:
    push    hl

    add     a
    ld      hl, nexos_idt
    
    add     l
    ld      l, a
    
    jp      (hl)

;; *************************
;; *** System Data Table ***
;; *************************

nexos_sdt:

    ;; unistd process

    defw    fork
    defw    exec
    defw    exit
    defw    wait

    ;; unistd memory

    defw    brk
    defw    mmap

    ;; signals

    defw    kill
    defw    sigaction
    defw    sigprocmask
    defw    sigsuspend

    ;; time

    defw    time
    defw    tzset

;; *******************
;; *** Kernel main ***
;; *******************

nexos_main:
    ret