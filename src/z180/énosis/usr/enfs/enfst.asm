;; SPDX-License: GPL-2

;; ****************************
;; *** @author: Έnosis Tech ***
;; *** @file: enfst.asm     ***
;; *** @date: 16/04/2025    ***
;; ****************************

;; ********************
;; *** Import files ***
;; ********************

include		"usr/enfs/enfst.inc"

;; **************************
;; *** Έnosis File System ***
;; **************************

ENFS_START:

;; Parte alta: Información de solo lectura
	

	;; Seguridad

ENFS_VERSION_ID:		defw	VERSION_ID		;; ID de la versión (1 bytes para versión, 4 bits para menor y 4 bits para patch)
ENFS_DIGITAL_FIRM:		defw	DIGITAL_FIRM 	;; Firma digital de la tabla
ENFS_TABLE_EXTEND:		defb	TABLE_EXTEND	;; Extend table
ENFS_TABLE_SIZE:		defb	TABLE_SIZE		;; Tamaño de la tabla

	;; Información de memoria

ENFS_NAME_MIN:			defb	NAME_SIZE_MIN	;; Tamaño mínimo de carácteres en el nombre
ENFS_NAME_MAX:			defb	NAME_SIZE_MAX	;; Tamaño máximo de carácteres en el nombre
ENFS_CLUSTER:			defw	CLUSTER_SIZE	;; Tamaño de los clusters
ENFS_SIZE_FILE:			defw	SIZE_FILE		;; Tamaño máximo de un archivo (teórico)
ENFS_LIMIT_NODES_MIN:	defW	LIMIT_NODES_MIN	;; Límite mínumo de nodos
ENFS_LIMIT_NODES_MAX:	defw	LIMIT_NODES_MAX	;; Límite máximo de nodos

;; Parte baja: Información de lectura y escritura

	;; Información de seguridad

ENFS_TYPE:				defs	TYPE		;; Indica el tipo de archivo
ENFS_FILE_ID:			defs	FILE_ID		;; ID de el archivo
ENFS_FOLDER_ID:			defs	FOLDER_ID	;; ID de la carpeta

	;; Información dinámica (que nunca es la misma por archivo)

ENFS_LIMIT_NAME_FILE:	defs	LIMIT_NAME_FILE 	;; Buffer file name
ENFS_LIMIT_SIZE_FILE:	defs	LIMIT_SIZE_FILE		;; File size limit

ENFS_LIMIT_NAME_FOLDER:	defs	LIMIT_NAME_FOLDER	;; Buffer folder name
ENFS_LIMIT_SIZE_FOLDER:	defs	LIMIT_SIZE_FOLDER	;; Folder size limit

ENFS_END: