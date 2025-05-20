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
    ld       a, $01 ;; A = 1 -> Active process
    ld     (hl), a  ;; Lo establecemos como activo

;; Nos desplazamos al siguiente elemento del arreglo
    
    ld      de, $0024   ;; Establecemos DE en 0x24 porque ya nos desplazamos
                        ;; un byte previamente (con inc hl) y cada bloque ocupa
                        ;; 0x25 bytes en total

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
    ld      a, $FF  ;; A = -1 -> Indica error
    ret             ;; Finalización de la ejecución de fork

;; *************************
;; *** Execute a process ***
;; *************************

exec:
    ;; TODO: Implementar ejecución de binarios
    ret

;; ****************************
;; *** Exit current process ***
;; ****************************

exit:
    ld      hl, (fnp) ;; Obtener el puntero al proceso actual
    ld      de, PSIZE ;; Process size
    add     hl, de    ;; Actual - PSIZE = anterior + 1

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
    push    bc
    pop     bc
    ret

;; **************************************
;; *** Implementation of the freelist ***
;; ***      algorithm allocator       ***
;; **************************************

;; mblock* mblk_create(size_t n)

mblk_init:
    
    ;; Init values
    xor     a
    ld      de, $2000
    ld      hl, freelist
    
    ;; Size

    ld      (hl), e
    
    inc     hl
    ld      (hl), d

    ;; Next

    inc     hl
    ld      (hl), a

    inc     hl
    ld      (hl), a

    ret

fla_malloc:
    push    bc
    push    iy
    ld      iy, $FFF9
    add     iy, sp
    ld      sp, iy

    ;; de = size and hl is free

    ex      de, hl

    ;; Prev = null

    xor     a

    ld      (iy + 0), a
    ld      (iy + 1), a

    ;; curr = freelist

    ld      hl, (freelist)

    ld      (iy + 2), l
    ld      (iy + 3), h

    ;; total_size = size + 4

    ld      hl, $0004 ;; hl = 4
    add     hl, de    ;; hl = hl + size -> tsize = 4 + size

    ld      (iy + 4), l ;; save low
    ld      (iy + 5), h ;; save high

    ex      de, hl ;; de = total_size

fla_malloc_loop:

    ld      a, (iy + 3)
    cp      $00
    jr      z, fla_malloc_end

    ld      a, e
    cp      (iy + 2)
    jp      z, fla_malloc_is_curr_equal_tsize

fla_malloc_loop_continue:

    ld      a

    jp      fla_malloc_loop

fla_malloc_end:

    ld      iy, $0007
    add     iy, sp
    ld      sp, iy
    pop     iy
    pop     bc
    ret

fla_malloc_is_curr_equal_tsize:
    ld      a, d
    cp      (iy + 3)
    jp      nz, fla_malloc_loop_continue


fla_sub:
    ret

fla_find:
    ret

;; *****************************************
;; *** Implementation of the round robin ***
;; *** algorithm with a priority system  ***
;; *****************************************

rr_priority:
    ret

rr_save_context:
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

;; Free list

freelist: defw $DFFF

fla_ptr: defw fla_nodes

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

;; Pointers

fla_prev:
    defs $02

fla_curr:
    defs $02

fla_tsize:
    defs $02

fla_nodes:
    defs $64 * $04 ;; 400 bytes

;; Process list

plist:
    defs CHILD_MAX * PSIZE