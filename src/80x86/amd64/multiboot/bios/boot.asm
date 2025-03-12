;; SPDX-Lincense: GLP-2

;; farmat
format elf64

;; set instruction computer
use64

global main_boot

MAGIC_NUMBER = $E85250D6
ARCHITECTURE	= $00000000
SIZE_HEADER		= (.end - multiboot)
CHECKSUM_CALC	= -(MAGIC_NUMBER + ARCHITECTURE + SIZE_HEADER)

; Macros
FRAME_WIDTH		= 1080
FRAME_HEIGHT	= 720
FRAME_DEPTH		= 32

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
stack_start: resb 8192
stack_end:

;; Code section

section .text
align 8

main_boot:
    lea rsp, [stack_end]
    jmp halt

halt:
    hlt
    jmp halt

;; Data section
section .data
align 8