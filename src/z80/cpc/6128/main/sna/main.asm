buildsna
bankset 0
org #0000
run #0000

start
	ld	bc, #7F89
	out (c), c
	push bc

limit #FFFF