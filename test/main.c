// Macros

#define NULL ((void*) 0x0000)

#define true 1
#define false 0

#define MAX_SIZE_HEAP 0x800
#define MAX_SIZE_NODE sizeof(nodo_t) * 0x64
#define LIMIT_HIGH ()
#define LIMIT_LOW (0xFFFF - 0x1000)

// Aliases

typedef unsigned char bool;
typedef unsigned short size_t;

typedef void* uniptr_t;

typedef signed char    int8_t;
typedef signed short   int16_t;

typedef unsigned char  uint8_t;
typedef unsigned short uint16_t;

// *******************
// *** Estructuras ***
// *******************

typedef struct {

	bool free;
	size_t size;
	uniptr_t block;

} block_t;

typedef struct {

	block_t  block;
	uniptr_t next;

} nodo_t;

typedef struct {

	nodo_t* nodo;

} freelist;

// *****************
// *** Variables ***
// *****************

uint8_t heap[MAX_SIZE_HEAP];
uint8_t heap_nodo[MAX_SIZE_NODE];

uniptr_t ptr_heap_nodo;

uniptr_t current_break;   // Variable que simila el break del programa

// *******************************
// *** Prototipos de funciones ***
// *******************************

// Funciones importantes

void init(void);

// Funciones POSIX

void* sbrk(uniptr_t incr);
void* malloc(size_t size);

// Funciones no POSIX

nodo_t* crear_nodo(void);
nodo_t* solicitar_espacio(size_t size);

// ********************
// *** Función main ***
// ********************

void main(void) {
	int a = 10 + 20;
	int b = a + 20;
}

// *****************
// *** Funciones ***
// *****************

// Funciones importantes

void init(void) {
	ptr_heap_nodo = &heap_nodo[0];
	current_break = NULL;
}

/* Código del Eduardo :v */

// uniptr_t malloc(uint16_t size) {
//
//     if (ptr_heap_nodo == 0x0000)    goto error;
//     if (size == 0)                  goto nuller;
//     if (size > MAX_SIZE_HEAP)       goto nuller;
//
//     block_t* prev    = NULL;
//     nodo_t* current = crear_nodo(size);
//
//     current ->
//
//     if (current -> is_free) {
//
//         prev = current;
//
//         current = NULL;
//     }
//
//     prev -> is_free = 0x00;
//
//     return prev;
//
//     error:
//         return 0xFFFF;
//
//     nuller:
//         return NULL;
// }

// Definición de sbrk

void* sbrk(uniptr_t incr) {
	uint8_t* a = (uint8_t*) incr;
	*a++;
}

// Manejo de nodos

nodo_t* crear_nodo(void) {
	nodo_t* n = ptr_heap_nodo;

	n-> block.free  = 0x00;
	n-> block.size  = 0x0000;
	n-> block.block = NULL;

	n-> next = 	NULL;

	ptr_heap_nodo++;

	return n;
}

// Función para solicitar espacio en el heap cuando no hay

nodo_t* solicitar_espacio(size_t size) {
	size++;
	return (nodo_t*) size;
}