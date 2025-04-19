/* SPDX-License: GPL-2 */

/*
****************************
*** @author: Έnosis Tech ***
*** @file: i386.ld      ***
*** @date: 19/04/2025    ***
****************************
*/

/* Define OUTPUT_FORMAT */
OUTPUT_FORMAT(elf32-i386)

/* Defien entry boot */

ENTRY(main_boot)

/* Memory organization and length */
MEMORY {
    BOOT    (rx)    : ORIGIN = 000K + 1M, LENGTH = 64K
    TEXT    (rx)    : ORIGIN = 064K + 1M, LENGTH = 64K
    DATA    (rw)    : ORIGIN = 128K + 1M, LENGTH = 64K
    BSS     (rw)    : ORIGIN = 192K + 1M, LENGTH = 64K
    RODATA  (r)     : ORIGIN = 256K + 1M, LENGTH = 64K
    STACK   (rw)    : ORIGIN = 320K + 1M, LENGTH = 64K
}

/* SECTIONS: Defines various sections of the program and allocates them to memory regions.*/

/* COnfiguration of the sections */

SECTIONS {
	
	/* Special section for multiboot2 header */
    .boot : {
        KEEP(*(.boot))
        KEEP(*(.multiboot))

        KEEP(*(_BOOT))
        KEEP(*(_MULTIBOOT))
    } > BOOT

	/* Section for the code */
	.text : {
		*(.text)
		*(.code)

        *(_TEXT)
        *(_CODE)
    } > TEXT

    .data : {
        *(.data)
        *(_DATA)
    } > DATA

    .bss (NOLOAD) : {
        *(.bss)
        *(_BSS)
    } > BSS

    .rodata : {
        *(.rodata)
        *(_RODATA)
    } > RODATA

    .stack (NOLOAD) : {
        *(.stack)
        *(_STACK)
    } > STACK
}