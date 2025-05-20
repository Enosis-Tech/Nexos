// Macros

#include <time.h>
#define true 1
#define false 0

#define MAX_SIZE_HEAP 0x800
#define MAX_SIZE_NODE sizeof(nodo_t) * 0x64
#define LIMIT_HIGH ()
#define LIMIT_LOW  (0xFFFF - 0x1000)

// Aliases

typedef unsigned char   bool
typedef unsigned short  size_t;
typedef void*           uniptr_t;

// *******************
// *** Estructuras ***
// *******************

typedef struct {
    
    bool    free;
    struct block_t* next;
    size_t  size;
    
} block_t;

typedef struct {
    
    block_t   block;
    uniptr_t  next;
    
} nodo_t;

typedef struct {
    
    nodo_t* nodo;
    
} freelist;

// *****************
// *** Variables ***
// *****************

uint8_t heap_nodo[MAX_SIZE_NODE];
uint8_t heap[MAX_SIZE_HEAP];

void* ptr_heap_nodo = &heap_nodo[0];

// *****************
// *** Funciones ***
// *****************

// Función para solicitar espacio en el heap cuando on hay
block_t *solicitar_espacio(uint16_t size) {
    block_t *block = (block_t *)sbrk(0); // Obteer el puntero actual del break
    void *respuesta = sbrk(size + MAX_SIZE_HEAP); // Solicitamos más memoria el sistema

    if (respuesta == (void *) -1) {return NULL; // Sbrk falló}
    
    block -> size = size;
    block -> next = NULL;
    block -> free = 0x00;
    return block;
}

// void* malloc(uint16_t size) {
    
//     if (ptr_heap_nodo == 0x0000)    goto error;
//     if (size == 0)                  goto nuller;
//     if (size > MAX_SIZE_HEAP)       goto nuller;
    
//     block_t* prev    = NULL;
//     nodo_t* current = crear_nodo(size);
    
//     current -> 
    
//     if (current -> is_free) {
        
//         prev = current;
        
//         current = NULL;
//     }
    
//     prev -> is_free = 0x00;
    
//     return prev;
    
//     error:
//         return 0xFFFF;
    
//     nuller:
//         return NULL;
// }

nodo_t* crear_nodo(uint16_t size) {
    
    if (ptr_heap_nodo >= LIMIT_LOW) {
    
        nodo_t* n = ptr_heap_nodo;
    
        n -> data.is_free  = 0x01;
        n -> data.size     = size;
        n -> data.block    = ptr_heap_nodo;
        n -> data.next     = NULL;
    
        ptr_heap_nodo++;
    
        return n;
    }
    
    return NULL;
}

// ********************
// *** Función main ***
// ********************

void main(void) {
    
    void* a = malloc(0x0A);
}

















