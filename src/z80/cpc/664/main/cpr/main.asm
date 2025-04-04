buildcpr
bank 0
org #0000
run #0000

start
	ld	bc, #7F89
	out (c), c
	push bc

limit #1FFF

bank 1

org #4000

bank 2

org #8000

bank 3

org #c000

limit #FFFF