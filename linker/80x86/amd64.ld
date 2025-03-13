ENTRY(main_boot)

MEMORY {
	BOOT	(rx)	: ORIGIN = 000K + 1M, LENGTH = 64K
	TEXT	(rx)	: ORIGIN = 064K + 1M, LENGTH = 64K
	DATA	(rw)	: ORIGIN = 128K + 1M, LENGTH = 64K
	BSS		(rw)	: ORIGIN = 192K + 1M, LENGTH = 64K
	RODATA	(r)		: ORIGIN = 256K + 1M, LENGTH = 64K
	STACK	(rw)	: ORIGIN = 320K + 1M, LENGTH = 64K
}

SECTIONS {
	
	.boot : {
		KEEP(*(.boot))
		KEEP(*(.multiboot))

		KEEP(*(_BOOT))
		KEEP(*(_MULTIBOOT))
	} > BOOT

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
