;; SPDX-License

;; ****************************
;; *** @author Έnosis Tech	***
;; *** @version 00.00.01 	***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include		"kernel/time.inc"

;;
;;
;;

time:
	ret

;;
;;
;;

tzset:
	ret

;;
;;
;;

timer_create:
	xor		a			;; Clear register a
	out0	(TCR), a	;; Clear timer for security

	ld		 a, %00010111	;; TIE0 enable
							;; TIE1 enable
							;; TOC0 enable
							;; TDE0 enable
	
	out0	(TCR), a		;; Enable timer

	ret

;;
;;
;;

reload_timer:
	ld		a, STD_TIMER_VALUE	;; Define new value after
	out0	(TCR), a			;; Reload timer
	ret

;;
;;
;;

tie:
	in0		a, (TCR)
	bit		6, a
	ret		nz

	set		6, a
	ret