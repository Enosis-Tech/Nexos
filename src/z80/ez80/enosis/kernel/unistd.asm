;; SPDX-License-identifier: LGPL-3

;; **********************************
;; *** @author  Enosis Technology ***
;; *** @version 00.00.01		  ***
;; **********************************

;; **********************
;; *** Origin address ***
;; **********************

org		100h

;; **********************
;; *** Operation mode ***
;; **********************

.ASSUME ADL = 1

;; ********************
;; *** Import files ***
;; ********************

include		"../include/limits.inc"
include		"../include/unistd.inc"

;; *********************
;; *** Local aliases ***
;; *********************

RERROR equ -1

;; *********************
;; *** Global labels ***
;; *********************

global		fork		;; Create process

;; *********************
;; *** Extern labels ***
;; *********************

extern		fnp			;; Free Next Process
extern		cproc		;; Counter process
extern		proc_ptr	;; Process pointer

;; ********************
;; *** Code section ***
;; ********************

section code

;; pid_t fork(void);

	fork:
		call	update_cproc
		cp		RERROR
		jp		z, fork_error
		
		push	bc
		
		pop		bc
		ret

	fork_error:
		ld		a, RERROR
		ret

;; void* sbrk(uniptr_t ptr);

	sbrk:
		ret


;; ****************
;; *** Freelist ***
;; ****************

;; Struct of freelist

;;	block_t
;;		free : uint8_t
;;		size : uint24_t
;;		blk* : uint24_t

;;	freelist
;;		block_t : 7 bytes
;;		prev*   : 3 bytes
;;		next*   : 3 bytes
;;	total: 13 bytes

;; freelist* create_freelist(void);

	create_freelist:
		call	update_cproc ;; Update cproc
		cp		RERROR		 ;; Verify if have a error
		ret		z			 ;; Return have a error
	
		push	bc	;; Save BC register
	
		ld		 a, 01h			;; A = 1
		ld		hl, (proc_ptr)	;; HL = current process
		ld		(hl), a			;; HL -> free = 1 (free process)
	
		inc		hl	;; hl -> size
	
		ld		bc, 000000h	;; bc = 0x000000
		ld		(hl), bc	;; hl -> size = bc (size undefined)
	
		inc		hl	;; hl = hl + 3, with 3 increments
		inc		hl	;; hl -> blk*
		inc		hl	;; undefined block memory
	
		ld		bc, NULL	;; bc = NULL
		ld		(hl), bc	;; hl -> blk* = bc
	
		inc		hl	;; hl = hl + 3, with 3 increments
		inc		hl	;; hl -> prev*
		inc		hl	;; not prev node (NULL)
	
		ld		bc, NULL	;; bc = NULL
		ld		(hl), bc	;; hl -> prev* = bc (not prev node)
	
		inc		hl	;; hl = hl + 3, with 3 increments
		inc		hl	;; hl -> next*
		inc		hl	;; undefined next node (NULL)
	
		ld		bc, NULL	;; bc = NULL
		ld		(hl), bc	;; hl -> next* = bc (undefined next node)
	
	;; Update pointer to heap process
	
		ld		hl, (proc_ptr)
		ld		bc, hl
	
		ld		de, 00000Dh
		add		hl, de
	
		ld		(proc_ptr), hl
	
	;; Return pointer to current process
	
		ld		hl, bc
	
	;; Finish the subrutine
		pop		bc
		ret

;; Update variables

	update_cproc:
		ld		a, (cproc)
		cp		CHILD_MAX
		jr		z, update_cproc_error

		ld		hl, cproc
		inc		(hl)
		ret

	update_cproc_error:
		ld		a, RERROR
		ret