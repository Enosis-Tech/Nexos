org		$000000

cpu z80

start:
	ld		 a, $10
	ld		hl, $FFFF
	ld		bc, $000000

continue:

cpu ez80

	ld		hl, $FFFF

	jp		$FFFFFC

org $FFFFFC

finaly: ld		hl, $FFFFFF