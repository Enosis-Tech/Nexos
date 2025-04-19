/* SPDX-License: GPL-2 */

/*
****************************
*** @author: Έnosis Tech ***
*** @file: 8086.ld      ***
*** @date: 19/04/2025    ***
****************************
*/

/* Define entry boot */
ENTRY(main_nexos)

/* Memory organization and length */

MEMORY {
	BOOT	(rx)	: ORIGIN = 0x600 + 0x0000 + (0xFFFF * 0), LENGTH = 0xFFFF
	TEXT	(rx)	: ORIGIN = 0x600 + 0xFFFF + (0x3333 * 0), LENGTH = 0x3333
	DATA	(rw)	: ORIGIN = 0x600 + 0xFFFF + (0x3333 * 1), LENGTH = 0x3333
	BSS		(rw)	: ORIGIN = 0x600 + 0xFFFF + (0x3333 * 2), LENGTH = 0x3333
	RODATA	(r)		: ORIGIN = 0x600 + 0xFFFF + (0x3333 * 3), LENGTH = 0x3333
	STACK	(rw)	: ORIGIN = 0x600 + 0xFFFF + (0x3333 * 4), LENGTH = 0x3333
}

/* COnfiguration of the sections */

SECTIONS {
	
	/* Special section for multiboot2 header */

	.boot : {
		KEEP(*(.boot))
		KEEP(*(_BOOT))
	} > BOOT


	/* Section for the code */

	.text : {
		*(.text)
		*(.code)

		*(_TEXT)
		*(_CODE)
	} > TEXT

	/* Section for the initialized data */

	.data : {
		*(.data)
		*(_DATA)
	} > DATA

	/* Section for the unitialized data */

	.bss (NOLOAD) : {
		*(.bss)
		*(_BSS)
	} > BSS

	/* Section for the only read data (constants) */

	.rodata : {
		*(.rodata)
		*(_RODATA)
	} > RODATA

	/* Section for the stack */

	.stack (NOLOAD) : {
		*(.stack)
		*(_STACK)
	} > STACK

}