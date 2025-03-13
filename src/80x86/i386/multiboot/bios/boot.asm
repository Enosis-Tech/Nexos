;; SPDX-License: GPL-2

;; ****************************
;; *** @file: boot.asm		***
;; *** @author: Pexnídi inc	***
;; *** @date: 13/03/2025	***
;; ****************************

;; ***********************
;; *** Set format file ***
;; ***********************

format elf

;; ********************************
;; *** Set instruction computer ***
;; ********************************

use32

;; **********************************************
;; *** Set visible labes for linker (ld/gold) ***
;; **********************************************

public main_boot

;; ************************************
;; *** Import macros and structures ***
;; ************************************

include "include/80x86/i386/multiboot/boot.inc"

;; ******************************
;; *** Sectiion for multiboot ***
;; ******************************

section '_MULTIBOOT' executable align 8
	
	align 8
	multiboot:
		.magic:		dd MAGIC_NUMBER		;; Magic number
		.arch:		dd ARCHITECTURE		;; Architecture (i386)
		.size:		dd SIZE_HEADER		;; Size of the all tags in the multiboot2 header
		.checksum:	dd CHECKSUM_CALC	;; Checksum

		align 8
		.info_request:
			dw TAG_INFO_REQUEST
			dw 0
			dd .info_request.end - .info_request
			dd 4, 5, 6
		.info_request.end:

		align 8
		.header_address:
			dw TAG_HEADER_ADDRESS
			dw 0
			dd 24
			dd multiboot
			dd multiboot
			dd .end
			dd bss.end

		align 8
		.tag_entry:
			dw TAG_KERNEL_ENTRY	;; Tag id
			dw 0				;; Flag number
			dd 12				;; Length of tag
			dd main_boot		;; Entry of the tag

		align 8
		.flag:
			dw TAG_KERNEL_FLAG
			dw 0
			dd 12
			dd 0

		align 8
		.framebuffer:
			dw TAG_FRAMEBUFFER
			dw 0
			dd 20
			dd FRAME_WIDTH
			dd FRAME_HEIGHT
			dd FRAME_DEPTH

		align 8
		.alignament:
			dw TAG_ALIGNAMENT
			dw 0
			dd 8

		align 8
		.tag_end:
			dw TAG_END
			dw 0
			dd 8

	.end:

;; ***********************************************
;; *** BSS section for the tag 2 of multiboot2 ***
;; ***********************************************

section '_BSS' writeable align 4
	
	align 4
	bss: rb $2000
	.end:

;; *********************************
;; *** Section of configurations ***
;; *********************************

section '_CODE' executable align 8

	align 8
	main_boot:
		lea esp, [stack_end]

		jmp halt

;; ************************************
;; *** Common labes for the entries ***
;; ************************************

section '_CODE' executable align 8
	
	align 8
	halt:
		times 16 hlt
		jmp halt

;; *************************************************
;; *** Section for the structures of information ***
;; *************************************************

section '_DATA' writeable align 4
	


;; *************************************************
;; *** Section for the stcak from configurations ***
;; *************************************************

section '_STACK' writeable align 4
	
	align 4
	stack_end: rb $2000
	stack_start:

times 0xFFFF - ($ - $$) db $00