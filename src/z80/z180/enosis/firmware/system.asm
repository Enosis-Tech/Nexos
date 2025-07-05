;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech	***
;; *** @version 00.00.08	***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

;; *********************
;; *** System reboot ***
;; *********************

system_reboot:
	
	di

	ld		ix, $0000
	ld		iy, $BFFF
	ld		sp, iy

	ld		a, ($0000)
	cp		$F3
	jp		nz, system_reboot_back_up

	ld		a, ($000F)
	cp		$AF
	jp		nz, system_reboot_back_up

	jp		$0000



system_reboot_back_up:

	di
	
	ld		hl, system_reboot_backing
	ld		de, $0000
	ld		bc, $0010
	ldir

	xor		a
	
	ld		h, a
	ld		l, a

	ld		b, a
	ld		c, a

	ld		d, a
	ld		e, a

	ld		a, ($)
	cp		$3A
	jp		z, $0000

	jr		system_reboot_back_up



system_reboot_backing:
	
	defb	$f3
	defb	$af
	defb	$47
	defb	$4f
	defb	$57
	defb	$5f
	defb	$67
	defb	$6f
	defb	$3e, $3e
	defb	$fe, $3e
	defb	$ca, $3c, $01
	defb	$af

system_reboot_backing_space: defs $20

;; *******************
;; *** System load ***
;; *******************

system_load:
	ret