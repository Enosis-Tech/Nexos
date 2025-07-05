;; SPDX-License-identifier: LGPL-3

;; **********************
;; *** Origin Address ***
;; **********************

org 2000h

;; ********************
;; *** Import files ***
;; ********************

include		"../include/limits.inc"

;; *********************
;; *** Local aliases ***
;; *********************

PSIZE	equ 0Dh					;; Process Size
HPSIZE	equ CHILD_MAX * PSIZE	;; Heap Process Size

;; *********************
;; *** Global labels ***
;; *********************

global		hprocess

;; *******************
;; *** BSS section ***
;; *******************

section bss

hprocess: ds HPSIZE