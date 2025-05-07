;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01 	***
;; ****************************

;; ******************************
;; *** Generate secure number ***
;; ******************************

secure_number:
	xor		a
	or		$C0
	rlca
	or		$C0

	cp		$3F
	jp		z, secure_number_case_error
	jp		p, secure_number_case_error

	and		$EF
	add		$04
	set		0, a
	set		1, a
	xor		$84
	sub		%00000100

	tst		%00011000
	jp		z, secure_number_case_error

	add		$01
	rlca

secure_number_case_error:
	and		$00
	jp		$0048