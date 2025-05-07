;; SPDX-License

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01	***
;; ****************************

;; **********************
;; *** Origin address ***
;; **********************

org         $2000

;; ******************
;; *** Bootloader ***
;; ******************

include     "bootloader/boot.asm"

limit_bootloader: defs $2000 - ($ - $2000)