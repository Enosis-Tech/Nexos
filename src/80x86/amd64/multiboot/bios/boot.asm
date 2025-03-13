;; SPDX-Lincense: GPL-2

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
global main_boot

MAGIC_NUMBER    = 0xE85250D6
ARCHITECTURE	= 0x00000000
SIZE_HEADER		= (.end - multiboot)
CHECKSUM_CALC	= -(MAGIC_NUMBER + ARCHITECTURE + SIZE_HEADER)

;; *******************************************
;; *** Macros for the header of multiboot2 ***
;; *******************************************
FRAME_WIDTH		= 1080
FRAME_HEIGHT	= 720
FRAME_DEPTH		= 32

;; *********************************************
;; *** Macros for the tags of the multiboot2 ***
;; *********************************************
TAG_END				= 0
TAG_INFO_REQUEST	= 1
TAG_HEADER_ADDRESS	= 2
TAG_KERNEL_ENTRY	= 3
TAG_KERNEL_FLAG		= 4
TAG_FRAMEBUFFER		= 5
TAG_ALIGNAMENT		= 6
TAG_EFI_SERVICE		= 7
TAG_EFI_ENTRY_X64	= 8

;; *********************************
;; *** Structures of information ***
;; *********************************
struc BOOT_CMD {
	.type:		dq 1
	.size:		dq .string - .type
	.string:	db "  "
}

struc BOOT_LOADER_NAME {
	.type:		dq 2
	.size:		dq .string - .type
	.string:	db "Nexos"
}

struc MODULES {
	.type:		dq 3
	.size:		dq .string - .type
	.mod_start:	dq 0
	.mod_end:	dq 0
	.string:	db "  "
}

struc MEMORY_INFO {
	.type:		dq 4
	.size:		dq 16
	.mem_lower:	dq 0
	.mem_upper:	dq 0
}

struc BIOS_BOOT_DEVICE {
	.type:			dq 5
	.size:			dq 20
	.biosdev:		dq 0
	.partition:		dq 0
	.sub_partition:	dq 0

}

struc MEMORY_MAP {
	.type:			dq 6
	.size:			dq .reserved - .type
	.entry_size:	dq 0
	.entry_version:	dq 0
	.base_addr:		dq 0
	.length:		dq 0
	.type_two:		dq 0
	.reserved:		dq 0
}

struc VBE_INFO {
	.type:				dq 7
	.size:				dq 784
	.vbe_mode:			dw 0
	.vbe_interface_seg:	dw 0
	.vbe_interface_off:	dw 0
	.vbe_interface_len:	dw 0
	.vbe_control_info:	rb 0x200
	.vbe_mode_info:		rb 0x100
}

;; ******************************
;; *** Sectiion for multiboot ***
;; ******************************

ection '_MULTIBOOT' executable align 8
	
	align 8
	multiboot:
		.magic:		dq MAGIC_NUMBER
		.arch:		dq ARCHITECTURE
		.size:		dq SIZE_HEADER
		.checksum:	dq CHECKSUM_CALC

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
			dq multiboot
			dq multiboot
			dq .end
			dq bss.end
		.header_address.end:

		align 8
		.tag_entry:
			dw TAG_KERNEL_ENTRY	;; Tag id
			dw 0				;; Flag number
			dd 12				;; Length of tag
			dq main_boot		;; Entry of the tag

		align 8
		.flag:
			dw TAG_KERNEL_FLAG
			dw 0
			dd 12
			dq 0

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
		.efi_boot_entry_i386:
			dw TAG_EFI_ENTRY_X64
			dw 0
			dd 12
			dq main_boot

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
	bss: rb 0x2000
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
	stack_end: rb 0x2000
	stack_start:

times 0xFFFF - ($ - $$) db 0