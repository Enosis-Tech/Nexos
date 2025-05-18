;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01    ***
;; ****************************

;; *********************************************************************
;; *** POSIX Standard: 2.5 Primitive System Data Types <sys/types.h> ***
;; *********************************************************************

ifndef __SYS_TYPES_INC__
define __SYS_TYPES_INC__

;; *******************************
;; *** Used for device numbers ***
;; *******************************

ifndef __DEV_T_DEFINED
define __DEV_T_DEFINED
#define dev_t defb
endif

;; **************************
;; *** Used for group IDs ***
;; **************************

ifndef __GID_T_DEFINED
define __GID_T_DEFINED
#define gid_t defb
endif

;; ************************************
;; *** Used for file serial numbers ***
;; ************************************

ifndef __INO_T_DEFINED
define __INO_T_DEFINED
#define ino_t defw
endif

;; ******************************************************
;; ***        Used for some file attributes,		  ***
;; *** for example file type, file access permissions ***
;; ******************************************************

ifndef __MODE_T_DEFINED
define __MODE_T_DEFINED
#define mode_t defb
endif

;; ****************************
;; *** Used for link counts ***
;; ****************************

ifndef __NLINK_T_DEFINED
define __NLINK_T_DEFINED
#define nlink_t defb
endif

;; ***************************
;; *** Used for file sizes ***
;; **************************

ifndef __OFF_T_DEFINED
define __OFF_T_DEFINED
#define off_t defw
endif

;; **************************************************
;; *** Used for process IDs and process group IDs ***
;; **************************************************

ifndef __PID_T_DEFINED
define __PID_T_DEFINED
#define pid_t defb
endif

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

;; *************************
;; *** Used for user IDs ***
;; *************************

ifndef __UID_T_DEFINED
define __UID_T_DEFINED
#define uid_t defb
endif

endif