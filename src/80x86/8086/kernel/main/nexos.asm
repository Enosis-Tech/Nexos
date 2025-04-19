;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: nexos.asm      ***
;; *** @date: 19/04/2025    ***
;; ****************************

format binary
use16

main_nexos:
		
	times 16 hlt

	jmp short main_nexos