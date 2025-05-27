;; **********************
;; *** Origin Address ***
;; **********************

org 1000h

;; *********************
;; *** Global labels ***
;; *********************

global		fnp
global		cproc
global		freelist
global		proc_ptr

;; *********************
;; *** Extern labels ***
;; *********************

extern		hprocess

;; ********************
;; *** Data section ***
;; ********************

section data

fnp:		db 00h
cproc:		db 00h
freelist:	dw dfffh
proc_ptr:	dw hprocess