;; SPDX-License: GPL-2

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

;; *******************************************
;; *** Macros for the header of multiboot2 ***
;; *******************************************

MAGIC_NUMBER	= $E85250D6
ARCHITECTURE	= $00000000
SIZE_HEADER		= (multiboot.magic - multiboot.end)
CHECKSUM_CALC	= -(MAGIC_NUMBER + ARCHITECTURE + SIZE_HEADER)

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
TAG_EFI_ENTRY_I386	= 8

;; **********************************
;; *** Macros for the framebuffer ***
;; **********************************

FRAME_WIDTH		= 1080
FRAME_HEIGHT	= 720
FRAME_DEPTH		= 32

;; *********************************
;; *** Structures of information ***
;; *********************************

struc BOOT_CMD {
	.type:		dd 1
	.size:		dd .string - .type
	.string:	db "  "
}

struc BOOT_LOADER_NAME {
	.type:		dd 2
	.size:		dd .string - .type
	.string:	db "Nexos"
}

struc MODULES {
	.type:		dd 3
	.size:		dd .string - .type
	.mod_start:	dd 0
	.mod_end:	dd 0
	.string:	db "  "
}

struc MEMORY_INFO {
	.type:		dd 4
	.size:		dd 16
	.mem_lower:	dd 0
	.mem_upper:	dd 0
}

struc BIOS_BOOT_DEVICE {
	.type:			dd 5
	.size:			dd 20
	.biosdev:		dd 0
	.partition:		dd 0
	.sub_partition:	dd 0

}

struc MEMORY_MAP {
	.type:			dd 6
	.size:			dd .reserved - .type
	.entry_size:	dd 0
	.entry_version:	dd 0
	.base_addr:		dq 0
	.length:		dq 0
	.type_two:		dd 0
	.reserved:		dd 0
}

struc VBE_INFO {
	.type:				dd 7
	.size:				dd 784
	.vbe_mode:			dw 0
	.vbe_interface_seg:	dw 0
	.vbe_interface_off:	dw 0
	.vbe_interface_len:	dw 0
	.vbe_control_info:	rb $200
	.vbe_mode_info:		rb $100
}

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
			dd main_boot	;; Entry of the tag

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