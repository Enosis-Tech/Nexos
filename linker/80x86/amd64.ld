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
    .data : {
        *(.data)
        *(_DATA)
    }

    .text : {
        *(.text)
        *(.code)
        *(_CODE)
        *(_TEXT)
    }
    .boot : {
        *(.multiboot)
        *(.boot)
        *(_MULTIBOOT)
        *(_BOOT)
    }
    
    
}