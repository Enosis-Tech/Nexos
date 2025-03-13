<<<<<<< HEAD
/ * It uses the ENTRY(main_boot) to set the starting point of the program. */
ENTRY(main_boot)

/* MEMORY: Defines memory regions with specific permissions and sizes.*/
=======
/* Defien entry boot */

ENTRY(main_boot)

/* Memory organization and length */

>>>>>>> cf238fe (Great update in header, Makefiles and source code)
MEMORY {
    BOOT    (rx)    : ORIGIN = 000K + 1M, LENGTH = 64K
    TEXT    (rx)    : ORIGIN = 064K + 1M, LENGTH = 64K
    DATA    (rw)    : ORIGIN = 128K + 1M, LENGTH = 64K
    BSS     (rw)    : ORIGIN = 192K + 1M, LENGTH = 64K
    RODATA  (r)     : ORIGIN = 256K + 1M, LENGTH = 64K
    STACK   (rw)    : ORIGIN = 320K + 1M, LENGTH = 64K
}

<<<<<<< HEAD
/* SECTIONS: Defines various sections of the program and allocates them to memory regions.*/
SECTIONS {
=======

/* COnfiguration of the sections */

SECTIONS {
	
	/* Special section for multiboot2 header */

	.boot : {
		KEEP(*(.boot))
		KEEP(*(.multiboot))
>>>>>>> cf238fe (Great update in header, Makefiles and source code)

    .boot : {
        KEEP(*(.boot))
        KEEP(*(.multiboot))

        KEEP(*(_BOOT))
        KEEP(*(_MULTIBOOT))
    } > BOOT

<<<<<<< HEAD
    .text : {
        *(.text)
        *(.code)
=======
	/* Section for the code */

	.text : {
		*(.text)
		*(.code)
>>>>>>> cf238fe (Great update in header, Makefiles and source code)

        *(_TEXT)
        *(_CODE)
    } > TEXT

<<<<<<< HEAD
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
=======
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
>>>>>>> cf238fe (Great update in header, Makefiles and source code)
