;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech	***
;; *** @version 00.00.01	***
;; ****************************

;; *********************************
;; *** Avoid file re-definitions ***
;; *********************************

ifndef __RGB565_INC__
define __RGB565_INC__

#define rgb565(r, g, b) (((r * 31) / 255) << 11) | (((g * 63) / 255) << 5) | ((b * 31) / 255)

BLACK equ rgb565($00, $00, $00)

endif