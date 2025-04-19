;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: boot.asm      ***
;; *** @date: 19/04/2025    ***
;; ****************************

;; ***********************
;; *** Set format file ***
;; ***********************

format elf64

;; ********************************
;; *** Set instruction computer ***
;; ********************************

use64

;; **********************************************
;; *** Set visible labes for linker (ld/gold) ***
;; **********************************************

public main_boot

;; ************************************
;; *** Import macros and structures ***
;; ************************************

include "include/80x86/amd64/multiboot/boot.inc"

;; ***********************************************
;; *** BSS section for the tag 2 of multiboot2 ***
;; ***********************************************

section '_BSS' writeable align 4
	
	align 4
	bss: rb $2000
	.end:

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
			dd .header_address.end - .header_address
			dd multiboot
			dd multiboot
			dd .end
			dd bss.end
		.header_address.end:

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
			dd 0

		align 8
		.framebuffer:
			dw TAG_FRAMEBUFFER
			dw 0
			dd 20
			dd ZERO
			dd ZERO
			dd ZERO

		align 8
		.alignament:
			dw TAG_ALIGNAMENT
			dw 0
			dd 8

		align 8
		.efi_boot_service:
			dw TAG_EFI_SERVICE
			dw 0
			dd 8

		align 8
		.efi_boot_entry_amd64:
			dw TAG_EFI_ENTRY_AMD64
			dw 0
			dd 12
			dd main_boot

		align 8
		.tag_end:
			dw TAG_END
			dw 0
			dd 8

	.end:

;; *********************************
;; *** Section of configurations ***
;; *********************************

section '_CODE' executable align 8

	align 8
	main_boot:
		lea rsp, qword [stack_end]

		jmp halt

;; **************************
;; *** Subrutines of boot ***
;; **************************
	
	align 8
	halt:
		times $10 hlt
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

times $FFFF - ($ - $$) db $00