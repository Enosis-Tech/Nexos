;; SPDX-License

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: main.asm      ***
;; *** @date: 16/04/2025    ***
;; ****************************

;; ****************
;; *** Firmware ***
;; ****************

include     "firmware/service.asm"
include     "firmware/idt.asm"
include     "firmware/graphics.asm"
include     "firmware/wakeup.asm"
include     "firmware/shutdown.asm"
include     "firmware/ram.asm"
include     "firmware/dma.asm"

;; limit_firmware: defs $1800 - ($ - 00)

;; ******************
;; *** Bootloader ***
;; ******************

include     "bootloader/boot.asm"

;; **************
;; *** Kernel ***
;; **************

;; *******************
;; *** User system ***
;; *******************