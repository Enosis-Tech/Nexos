;; SPDX-License: GPL-2

format pe64 dll

use64

section '.text' code executable readable

public efi_main:
	mov rdi, rcx	;; EFI_HANDLE
	mov rsi, rdx	;; EFI_SYSTEM_TABLE

	call output

	;; Salir de la UEFI
	mov rcx, rdi
	xor rdx, rdx
	call [rsi + 8] ;; Exit_Boot_Service

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
