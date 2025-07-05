;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include     "time.inc"
include     "macros/stdreg.inc"

;; *********************
;; *** Timer defined ***
;; ***   for POSIX   ***
;; *********************

time:
    ret

;; *******************
;; *** Search info ***
;; *******************

tzset:
    ret