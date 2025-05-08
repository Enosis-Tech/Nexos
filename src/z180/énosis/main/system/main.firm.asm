;; SPDX-License

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01	***
;; ****************************

;; **********************
;; *** Origin address ***
;; **********************

org         $0000

;; ****************
;; *** Firmware ***
;; ****************

include     "firmware/init.asm"
include     "firmware/service.asm"
include     "firmware/idt.asm"
include     "firmware/graphics.asm"
include     "firmware/wakeup.asm"
include     "firmware/shutdown.asm"
include     "firmware/dma.asm"
include		"firmware/system.asm"
include		"firmware/secure.asm"

limit_firmware: defs $2000 - ($ - $0000)