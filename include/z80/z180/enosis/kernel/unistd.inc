;; SPDX-License: GPL-2

;; ***************************
;; *** @author Έnosis Tech ***
;; *** @version 00.00.00   ***
;; ***************************

;; *********************************
;; *** Avoid file re-definitions ***
;; *********************************

ifndef __UNISTD_INC__
define __UNISTD_INC__

;; ****************************************	
;; *** As defined in the C Standard {2} ***
;; ****************************************

ifndef __SIZE_T_DEFINED
define __SIZE_T_DEFINED
#define size_t defw
endif

;; ***************************************
;; *** Used by functions that return   ***
;; *** a count of bytes (memory space) ***
;; ***   or an error indication 	   ***
;; ***************************************

ifndef __SSIZE_T_DEFINED
define __SSIZE_T_DEFINED
#define ssize_t defw
endif

macro hola
endm

endif ;; unistd.inc