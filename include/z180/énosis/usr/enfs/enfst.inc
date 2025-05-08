;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: enfst.inc     ***
;; *** @date: 16/04/2025    ***
;; ****************************

IFNDEF __FST_INC__
__FST_INC__ equ 1

VERSION_ID          equ     $0001
DIGITAL_FIRM        equ     $F5E5
TABLE_EXTEND        equ     $0000
TABLE_SIZE          equ     ENFS_END - ENFS_START

NAME_SIZE_MIN       equ     $01
NAME_SIZE_MAX       equ     $3C
CLUSTER_SIZE        equ     $0002
SIZE_FILE           equ     $FFFFFF
LIMIT_NODES_MIN     equ     $0000
LIMIT_NODES_MAX     equ     $FFFF

FILE_TYPE           equ     $02
FILE_ID             equ     $02
FOLDER_ID           equ     $02

LIMIT_NAME_FILE     equ     $3C
LIMIT_SIZE_FILE     equ     $04

LIMIT_NAME_FOLDER   equ     $3C
LIMIT_SIZE_FOLDER   equ     $04

ENDIF