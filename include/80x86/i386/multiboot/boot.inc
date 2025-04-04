;; SPDX-License: GPL-2

;; ****************************
;; *** @file: boot.inc		***
;; *** @author: Pexnídi inc	***
;; *** @date: 13/03/2025	***
;; ****************************

;; ************************
;; *** Evit reinclusion ***
;; ************************

if ~defined __BOOT_INC__
__BOOT_INC__ equ 1

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
TAG_EFI_ENTRY_AMD64	= 9

;; **************************************
;; *** Length of tags from multiboot2 ***
;; **************************************

SIZE_INFO_REQUEST		= 1
SIZE_HEADER_ADDRESS		= 2
SIZE_KERNEL_ENTRY		= 3
SIZE_KERNEL_FLAG		= 4
SIZE_FRAMEBUFFER		= 5
SIZE_ALIGNAMENT			= 6
SIZE_EFI_SERVICE		= 7
SIZE_EFI_ENTRY_I386		= 8
SIZE_EFI_ENTRY_AMD64	= 9

;; **********************************
;; *** Macros for the framebuffer ***
;; **********************************

FRAME_WIDTH		= 1080
FRAME_HEIGHT	= 720
FRAME_DEPTH		= 32

;; *********************************
;; *** Structures of information ***
;; *********************************

;; **********************************************
;; *** Structure for command line in the boot ***
;; **********************************************

struc BOOT_CMD {
	.type:		dd 1
	.size:		dd .string - .type
	.string:	db "  "
}

;; ****************************************************
;; *** Structure for the set name of the bootloader ***
;; ****************************************************

struc BOOT_LOADER_NAME {
	.type:		dd 2
	.size:		dd .string - .type
	.string:	db "Nexos"
}

;; *******************************************
;; *** Structure for the charge from mdule ***
;; *******************************************

struc MODULES name {
	.type:		dd 3
	.size:		dd .string - .type
	.mod_start:	dd 0
	.mod_end:	dd 0
	.string:	db name
}

;; ***********************************************
;; *** Structure to get information from grub ***
;; ***********************************************

struc MEMORY_INFO {
	.type:		dd 4
	.size:		dd 16
	.mem_lower:	dd 0
	.mem_upper:	dd 0
}

;; ************************************************
;; *** Structure for the mantence BIOS services ***
;; ************************************************

struc BIOS_BOOT_DEVICE {
	.type:			dd 5
	.size:			dd 20
	.biosdev:		dd 0
	.partition:		dd 0
	.sub_partition:	dd 0

}

;; *************************************************
;; *** Structure to get memory map of the system ***
;; *************************************************

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

;; **********************************************
;; *** Structure to get a framebuffer of VESA ***
;; **********************************************

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

end if