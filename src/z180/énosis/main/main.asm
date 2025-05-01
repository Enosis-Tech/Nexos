;; SPDX-License

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: main.asm      ***
;; *** @date: 16/04/2025    ***
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

;; limit_firmware: defs $4000 - ($ - 00)

;; ******************
;; *** Bootloader ***
;; ******************

include     "bootloader/boot.asm"

;; limit_bootloader: defs $4000 - ($ - $3FFF)

;; **************
;; *** Kernel ***
;; **************

include		"kernel/nexos.asm"
include		"kernel/time.asm"
include		"kernel/unistd.asm"
include		"kernel/signal.asm"

;; limit_kernel: defs $1000 - ($ - $7FFF)

;; *******************
;; *** User system ***
;; *******************

include		"usr/enfs/enfst.asm"