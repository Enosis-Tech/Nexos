if ~defined __BIOS_INC__
__BIOS_INC__ equ 1

BIOS_READ_SECTORS			equ $02 ;; BIOS service
NUMBER_OF_SECTORS_TO_READ	equ $08 ;; Sectors to read
LOW_BITS_CYLINDER_NUMBER	equ $02 ;; Number of cylinder
SECTORS_TO_READ				equ $02 ;; Sectors to read per cylinder
HEAD_NUMBER					equ $00 ;; Number of the header
DRIVE_NUMBER				equ $00 ;; Drive 0 is a floppy drive
BUFFER_TO_READ_SECTOR		equ $00	;; Read sector
DIR_SECOND_SECTOR			equ $7E0 ;; ES of ES:BX

ZERO	equ $00		;; Zero value

macro ld a, b {
	if b = 0
		xor		a, a
	else
		mov		a, b
	end if
}

end if