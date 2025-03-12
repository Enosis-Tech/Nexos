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

MAGIC_NUMBER    = $E85250D6
ARCHITECTURE	= $00000000
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
TAG_EFI_ENTRY_I386	= 8

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


section .multiboot
align 8
multiboot: 
    .magic: dd MAGIC_NUMBER
    .arch: dd ARCHITECTURE
    .size: dd SIZE_HEADER
    .checksum: dd CHECKSUM_CALC

    align 8
    .info_request:
        dw 1
        dw 0
        dd .info_request.end - .info_request
        dd 4, 5, 6
    .info_request.end

    align 8
    .header_address:
        dw 2
        dw 0
        dd 24
        dd multiboot
        dd multiboot
        dd .end
    
    align 8
    .flag:
        dw 4
        dw 0
        dd 12
        dd 0
    
    align 8
    .framebuffer:
        dw 5
        dw 0
        dd 20
        dd FRAME_WIDTH
        dd FRAME_HEIGHT
        dd FRAME_DEPTH
    
    align 8
    .alignament:
        dw 6
        dw 0
        dd 8

    align 8
    .tag_end:
        dw 0
        dw 0 
        dd 8
    .end

;; BSS section
section .bss
align 8
stack_start: resb 8192 ; 8KB
stack_end:

;; Code section

section .text
align 8

main_boot:
    lea rsp, [stack_end]
    cli ; Disable interrupts
    jmp halt

halt:
    hlt
    jmp halt

;; Data section
section .data
align 8