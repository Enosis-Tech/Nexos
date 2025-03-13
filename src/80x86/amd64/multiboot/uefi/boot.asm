;; SPDX-License: GPL-2

<<<<<<< HEAD
format pe64 dll efi

use64

section '.text' code executable readable

public efi_main
efi_main:
	mov rdi, rcx	;; EFI_HANDLE
	mov rsi, rdx	;; EFI_SYSTEM_TABLE

	call output

	;; Salir de la UEFI
	mov rcx, rdi	;; EFI HANDLE
	mov rdx, rsi	;; EFI_SYSTEM_TABLE
	call exit_boot_service ;; Exit_Boot_Service

	;; Retornar 
	xor eax, eax
	ret

; Salir de los servicios de la UEFI
exit_boot_service:
	mov r8, rsi 	;; EFI SYSTEM TABLE
	mov rcx, rdi	;; EFI HANDLE
	xor rdx, rdx	;; Mapkey
	call [rsi + 8]	;; EXIT_BOOT_SERVICE
	ret

;; Imprimir mensaje en la pantalla
output:
	mov rax, [rsi + 5 * 8] ;; ConOut

	mov rcx, rax
	lea rdx, [message]
	call [rax + 8] ;; Output_String

	ret

;; Data
section '.data' data readable writeable

message db 'Boot UEFI exitoso!', 0

;; Stack (para el retorno de la UEFI)

section '.bss' writeable

stack resb 8192 ;; 8KB
=======
;; ****************************
;; *** @file: boot.asm		***
;; *** @author: Pexnídi inc	***
;; *** @date: 13/03/2025	***
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

;; ******************************
;; *** Sectiion for multiboot ***
;; ******************************

section '_MULTIBOOT' executable align 8
	
	align 8
	multiboot:
		.magic:		dd MAGIC_NUMBER
		.arch:		dd ARCHITECTURE
		.size:		dd SIZE_HEADER
		.checksum:	dd CHECKSUM_CALC

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
		lea rsp, [stack_end]

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
>>>>>>> cf238fe (Great update in header, Makefiles and source code)
