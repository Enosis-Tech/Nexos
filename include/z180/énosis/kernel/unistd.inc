;; SPDX-License

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: process.asm   ***
;; *** @date: 16/04/2025    ***
;; ****************************

IFNDEF __UNISTD_INC__
__UNISTD_INC__ equ 1

SIZE_PROCESS	equ $07
NUMBER_PROCESS	equ $1E
SPACE_PROCESS	equ SIZE_PROCESS * NUMBER_PROCESS

ENDIF