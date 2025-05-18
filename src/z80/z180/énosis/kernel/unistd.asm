;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

;; Posix files

include     "time.inc"
include     "unistd.inc"
include     "limits.inc"
include     "sys/types.inc"

;; Macros files

include     "macros/isc.inc"
include     "macros/stdreg.inc"
include     "macros/aliases.inc"

;; ********************
;; *** Section code ***
;; ********************

section _CODE

;; Create a process
;; prototype: pid_t fork(void);

fork:

;; Verificación del límite para evitar desbordamiento
;; y ejecución de instrucciones extra

    ld      a, (cproc)      ;; Obtenemos de cproc el número actual de procesos
    cp      CHILD_MAX + 1   ;; No puede ser mayor a CHILD_MAX
    jr      z, fork_error   ;; Manejamos el error

;; Establacer pid del proceso
    
    ld      hl, (fnp) ;; Obtenemos el puntero al arreglo
    ld      (hl), a   ;; Le damos un id
    
;; Establecer estado del proceso
    
    inc     hl      ;; hl = hl + 1 -> puntero al estado
    inc     (hl)    ;; Lo establecemos como activo

;; Nos desplazamos al siguiente elemento del arreglo
    
    ld      de, $0025   ;; Establecemos el valor del registro
                        ;; DE a 0x25 debido aque cada índice
                        ;; del arreglo pesa eso

    add     hl, de      ;; Nos desplazamos en el arreglo

    ld      (fnp), hl   ;; Actualizamos el puntero
                        ;; para continuar en el siguiente
                        ;; puntero libre

;; Devolución del id del proceso
    
    ld      hl, cproc   ;; Obtenemos la dirección
                        ;; de memoria del contador
                        ;; de procesos activos

    inc     (hl)        ;; Actualizamos el contador
    ld      a, (hl)     ;; Devolvemos en a el valor del contador

fork_end:
    ret ;; Finalización de la ejecución de fork

fork_error:
    ld      a, $FF
    ret

;; *************************
;; *** Execute a process ***
;; *************************

exec:
    ret

;; ****************************
;; *** Exit current process ***
;; ****************************

exit:
    ld      hl, (fnp) ;; Obtener el puntero al proceso actual
    ld      de, $FFEC ;; -0x0014
    add     hl, de    ;; Actual - 0x0024 = anterior + 1

    xor     a       ;; Igualamos el registro a, a cero
    ld      (hl), a ;; estado = 0
    
    dec     hl      ;; Apuntamos al pid

    xor     a       ;; Se iguala a cero
    ld      (hl), a ;; pid = 0

    ld      (fnp), hl   ;; Indicamos que está libre

    ld      hl, cproc   ;; Obtenemos el contador de procesos activos
    dec     (hl)        ;; Lo decrementamos para indicar que un proceso murio

exit_end:
    ret ;; Finalización de la ejecución de exit

;; ************** *************
;; *** Wait for the child   *** 
;; *** process to finish    ***
;; ****************************

wait:
    ret

;; ****************************
;; ***   Gets the ID of     ***
;; *** the current process  ***
;; ****************************

getpid:
    ret

;; ************************************
;; *** Adjusts the upper heap limit ***
;; *** of a process (program break) ***
;; ************************************

brk:
    ret


;; *****************************************
;; *** Implementation of the round robin ***
;; *** algorithm with a priority system  ***
;; *****************************************

rr_priority:
    ret

rr_save_contex:
    ret

;; Level priority 0

rr_lp0:
    ret

;; Level priority 1

rr_lp1:
    ret

;; Level priority 2

rr_lp2:
    ret

;; Level priority 3

rr_lp3:
    ret

;; Level priority 4

rr_lp4:
    ret

;; Level priority 5

rr_lp5:
    ret

;; ********************
;; *** Data section ***
;; ********************

section _DATA

;; It has an alias called fnp to simplify programming.

free_next_process: defw plist

;; Quantums times

qt:
    defp qt0 ;; 990 KHz
    defp qt1 ;; 825 KHz
    defp qt2 ;; 660 KHz
    defp qt3 ;; 495 KHz
    defp qt4 ;; 330 KHz
    defp qt5 ;; 165 KHz

;; Counter process

cproc: defb $00

;; *******************
;; *** Section BSS ***
;; *******************

section _BSS

;; Process list

plist:
    defs CHILD_MAX * PSIZE