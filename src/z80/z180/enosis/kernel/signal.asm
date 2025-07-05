;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include     "signal.inc"

;; ***************************
;; *** Send signal for the ***
;; ***   current process   ***
;; ***************************

kill:
    ret

;; ***********************
;; *** sigaction POSIX ***
;; ***********************

sigaction:
    ret

;; ************************
;; *** Generate signal  ***
;; *** for use bit mask ***
;; ************************

sigprocmask:
    ret

;; ***************************
;; ***   Generate signal   ***
;; *** for suspend process ***
;; ***************************

sigsuspend:
    ret
