;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01    ***
;; ****************************

;; ***************************************************
;; *** POSIX Standard: 2.4 Error Numbers <errno.h> ***
;; ***************************************************

ifndef __ERRNO_INC__
define __ERRNO_INC__

ERRNO			equ errno

E2BIG 			equ $00
EACCES 			equ $01
EAGAIN 			equ $02
EBADF 			equ $03
EBUSY 			equ $04
ECHILD 			equ $05
EDEADLK 		equ $06
EDOM 			equ $07
EEXIST 			equ $08
EFAULT 			equ $09
EFBIG 			equ $0A
EINTR 			equ $0B
EINVAL 			equ $0C
EIO 			equ $0D
EISDIR 			equ $0E
EMFILE 			equ $0F
EMLINK 			equ $10
ENAMETOOLONG 	equ $11
ENFILE 			equ $12
ENODEV 			equ $13
ENOENT 			equ $14
ENOEXEC 		equ $15
ENOLCK 			equ $16
ENOMEM 			equ $17
ENOSPC 			equ $18
ENOSYS 			equ $19
ENOTDIR 		equ $1A
ENOTEMPTY 		equ $1B
ENOTTY 			equ $1C
ENXIO 			equ $1D
EPERM 			equ $1E
EPIPE 			equ $1F
ERANGE 			equ $20
EROFS 			equ $21
ESPIPE 			equ $22
ESRCH 			equ $23
EXDEV 			equ $24

endif ;; errno.inc