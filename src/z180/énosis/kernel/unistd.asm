;; SPDX-License

;; ****************************
;; *** @author Έnosis Tech	***
;; *** @version 00.00.01	***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include		"kernel/time.inc"
include		"kernel/unistd.inc"

;; ************************
;; *** Create a process ***
;; ************************

fork:
	ret

;; *************************
;; *** Execute a process ***
;; *************************

exec:
	ret

;; ****************************
;; *** Exit current process ***
;; ****************************

exit:
	ret

;; ************** *************
;; *** Wait for the child	*** 
;; *** process to finish	***
;; ****************************

wait:
	ret

;; ****************************
;; ***   Gets the ID of		***
;; *** the current process	***
;; ****************************

getpid:
	ret

;; ***
;; ***
;; ***

brk:
	ret

;; ***
;; ***
;; ***

mmap:
	ret

;; **************************
;; *** Process Data Table ***
;; **************************

process_id:			defs	$02
process_name:		defs	$3C
process_priority:	defs	$02
process_state:		defs	$01
process_quantum:	defs	$01
procees_cpu_time:	defs	$04
process_resources:	defs	$08