;; SPDX-License: GPL-2

;; ********************************
;; **** @author: Έnosis Tech	***
;; **** @version 00.00.01		***
;; ********************************

;; ***************************************************
;; *** POSIX 1990 Standard: 2.4 Error Numbers <errno.h> ***
;; ***************************************************

ifndef __STDINT_INC__
define __STDINT_INC__

ifndef __INT8_T_DEFINED
define __INT8_T_DEFINED
#define int8_t defb
endif

ifndef __INT16_T_DEFINED
define __INT16_T_DEFINED
#define int16_t defW
endif

ifndef __UINT8_T_DEFINED
define __UINT8_T_DEFINED
#define uint8_t defb
endif

ifndef __UINT8_T_DEFINED
define __UINT8_T_DEFINED
#define uint16_t defw
endif

endif