;; SPDX-License: GPL-2

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
