;; SPDX-License

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.0A	***
;; ****************************

;; **********************
;; *** Origin address ***
;; **********************

org         $0000

;; **************
;; *** Kernel ***
;; **************

include		"kernel/nexos.asm"
include		"kernel/time.asm"
include		"kernel/unistd.asm"
include		"kernel/signal.asm"

limit_kernel: defs $4000 - ($ - $7FFF)