#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <stdint.h>
#include <limits.h>

#define MAX_WINDOWS 50
#define HEAP_SIZE 4096
#define MSG_QUEUE_SIZE 128
#define MAX_CLASSES 10
#define MAX_USER_MESSAGES 100
#define MAX_CHILD_WINDOWS 10

// Definición de tipos
typedef long LRESULT;
typedef unsigned int UINT;
typedef unsigned long WPARAM;
typedef long LPARAM;
typedef unsigned long COLORREF;
typedef int BOOL;
typedef void* HBRUSH;
typedef void* HPEN;
typedef void* HFONT;
typedef void* HBITMAP;

// Estilos de ventana
#define WS_OVERLAPPED     0x00000000L
#define WS_POPUP          0x80000000L
#define WS_CHILD          0x40000000L
#define WS_VISIBLE        0x10000000L
#define WS_DISABLED       0x08000000L
#define WS_CAPTION        0x00C00000L
#define WS_SYSMENU        0x00080000L
#define WS_THICKFRAME     0x00040000L
#define WS_MINIMIZEBOX    0x00020000L
#define WS_MAXIMIZEBOX    0x00010000L

// Estilos extendidos
#define WS_EX_TOPMOST     0x00000008L

// Mensajes estándar
#define WM_NULL           0x0000
#define WM_CREATE         0x0001
#define WM_DESTROY        0x0002
#define WM_MOVE           0x0003
#define WM_SIZE           0x0005
#define WM_ACTIVATE       0x0006
#define WM_SETFOCUS       0x0007
#define WM_KILLFOCUS      0x0008
#define WM_PAINT          0x000F
#define WM_CLOSE          0x0010
#define WM_QUIT           0x0012
#define WM_ERASEBKGND     0x0014
#define WM_SHOWWINDOW     0x0018
#define WM_GETMINMAXINFO  0x0024
#define WM_WINDOWPOSCHANGING 0x0046
#define WM_WINDOWPOSCHANGED  0x0047
#define WM_COMMAND        0x0111
#define WM_KEYDOWN        0x0100
#define WM_KEYUP          0x0101
#define WM_CHAR           0x0102
#define WM_MOUSEMOVE      0x0200
#define WM_LBUTTONDOWN    0x0201
#define WM_LBUTTONUP      0x0202
#define WM_RBUTTONDOWN    0x0204
#define WM_MOUSEWHEEL     0x020A
#define WM_USER           0x0400

// Estructura de mensaje
typedef struct {
    UINT message;
    WPARAM wParam;
    LPARAM lParam;
    struct HWND__* hwnd; 
    bool isHighPriority; // Para mensajes prioritarios como WM_QUIT
} MSG;

// Estructura para tamaño mínimo/máximo
typedef struct {
    int minWidth;
    int minHeight;
    int maxWidth;
    int maxHeight;
} MINMAXINFO;

// Estructura para posición de ventana
typedef struct {
    int x;
    int y;
    int cx;
    int cy;
} WINDOWPOS;

// Estructura para región
typedef struct {
    int left;
    int top;
    int right;
    int bottom;
} RECT;

// Estructura para información de fuente
typedef struct {
    char faceName[32];
    int height;
    int weight;
    bool italic;
} LOGFONT;

// Cola de mensajes con prioridad
typedef struct {
    MSG queue[MSG_QUEUE_SIZE];
    int front;
    int rear;
    int count;
    int highPriorityCount;
} MessageQueue;

// Estructura de ventana extendida
typedef struct HWND__ {
    int x, y;
    int width, height;
    char* title;
    bool isClosed;
    bool isVisible;
    bool isEnabled;
    UINT id;
    const char* className;
    UINT style;
    UINT exStyle;
    struct HWND__* parent;
    struct HWND__* owner;
    struct HWND__* children[MAX_CHILD_WINDOWS];
    int childCount;
    int zOrder; // Orden de apilamiento (mayor = más arriba)
    void* userData;
    HBRUSH background;
    bool needsPaint;
    RECT updateRect;
    MINMAXINFO minMaxInfo;
    bool isDialog;
    bool isModal;
} HWND;

typedef LRESULT (*WNDPROC)(HWND*, UINT, WPARAM, LPARAM);

// Clase de ventana registrada
typedef struct {
    WNDPROC lpfnWndProc;
    const char* className;
    UINT style;
    HBRUSH hbrBackground;
    HFONT hFont;
    bool isRegistered;
} WNDCLASS;

// Contexto de dispositivo mejorado
typedef struct {
    HWND* hwnd;
    COLORREF currentColor;
    HBRUSH currentBrush;
    HPEN currentPen;
    HFONT currentFont;
    RECT clipRect;
    bool doubleBuffer;
    HBITMAP bufferBitmap;
} HDC;

// Sistema de ventanas principal
typedef struct {
    HWND windowPool[MAX_WINDOWS];
    bool windowInUse[MAX_WINDOWS];
    WNDCLASS registeredClasses[MAX_CLASSES];
    int classCount;
    char fakeHeap[HEAP_SIZE];
    size_t heapOffset;
    MessageQueue msgQueue;
    UINT nextWindowId;
    HWND* focusWindow;
    HWND* captureWindow;
    HWND* activeWindow;
    int nextZOrder;
    UINT userMessages[MAX_USER_MESSAGES];
    int userMessageCount;
} WindowSystem;

// Prototipos de funciones
void MessageQueue_init(MessageQueue* q);
BOOL MessageQueue_enqueue(MessageQueue* q, const MSG* msg);
BOOL MessageQueue_dequeue(MessageQueue* q, MSG* msg);
BOOL MessageQueue_peek(const MessageQueue* q, MSG* msg);
void WindowSystem_init(WindowSystem* ws);
void* WindowSystem_allocate(WindowSystem* ws, size_t size);
HWND* WindowSystem_findFreeWindowSlot(WindowSystem* ws);
HWND* WindowSystem_createWindow(WindowSystem* ws, const WNDCLASS* wndClass, 
                              const char* title, int x, int y, 
                              int width, int height, HWND* parent, HWND* owner, 
                              UINT style, UINT exStyle);
BOOL WindowSystem_destroyWindow(WindowSystem* ws, HWND* hwnd);
BOOL WindowSystem_postMessage(WindowSystem* ws, UINT msg, 
                            WPARAM wParam, LPARAM lParam, HWND* hwnd, bool highPriority);
BOOL WindowSystem_sendMessage(WindowSystem* ws, UINT msg, 
                            WPARAM wParam, LPARAM lParam, HWND* hwnd);
BOOL WindowSystem_getMessage(WindowSystem* ws, MSG* msg);
BOOL WindowSystem_peekMessage(WindowSystem* ws, MSG* msg);
BOOL WindowSystem_translateMessage(const MSG* msg);
BOOL WindowSystem_registerClass(WindowSystem* ws, const WNDCLASS* wndClass);
BOOL WindowSystem_unregisterClass(WindowSystem* ws, const char* className);
WNDCLASS* WindowSystem_findClass(WindowSystem* ws, const char* className);
void WindowSystem_updateZOrder(WindowSystem* ws, HWND* hwnd);
void WindowSystem_bringToTop(WindowSystem* ws, HWND* hwnd);
void WindowSystem_setFocus(WindowSystem* ws, HWND* hwnd);
void WindowSystem_setCapture(WindowSystem* ws, HWND* hwnd);
void WindowSystem_releaseCapture(WindowSystem* ws);
HWND* WindowSystem_getCapture(WindowSystem* ws);
void WindowSystem_setActiveWindow(WindowSystem* ws, HWND* hwnd);
HWND* WindowSystem_getActiveWindow(WindowSystem* ws);
void WindowSystem_invalidateRect(WindowSystem* ws, HWND* hwnd, const RECT* rect, bool erase);
void WindowSystem_updateWindow(WindowSystem* ws, HWND* hwnd);
void WindowSystem_redrawWindow(WindowSystem* ws, HWND* hwnd, const RECT* rect, bool erase);
UINT WindowSystem_registerUserMessage(WindowSystem* ws);
LRESULT DefWindowProc(HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
HDC BeginPaint(HWND* hwnd, RECT* updateRect);
void EndPaint(HWND* hwnd, HDC* hdc);
LRESULT DispatchMessage(WindowSystem* ws, const MSG* msg);
void WindowSystem_handleSizeMove(WindowSystem* ws, HWND* hwnd, int newWidth, int newHeight, int newX, int newY);
void WindowSystem_handleMinMaxInfo(WindowSystem* ws, HWND* hwnd, MINMAXINFO* info);
void WindowSystem_handleCommand(WindowSystem* ws, HWND* hwnd, WPARAM wParam, LPARAM lParam);
void WindowSystem_handleKeyboard(WindowSystem* ws, HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
void WindowSystem_handleMouse(WindowSystem* ws, HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam);

// Implementación de funciones

void MessageQueue_init(MessageQueue* q) {
    assert(q != NULL);
    q->front = 0;
    q->rear = 0;
    q->count = 0;
    q->highPriorityCount = 0;
}

BOOL MessageQueue_enqueue(MessageQueue* q, const MSG* msg) {
    assert(q != NULL && msg != NULL);
    
    if (q->count >= MSG_QUEUE_SIZE) {
        fprintf(stderr, "Error: Cola de mensajes llena\n");
        return false;
    }
    
    // Los mensajes de alta prioridad se colocan al frente
    if (msg->isHighPriority && q->highPriorityCount < MSG_QUEUE_SIZE / 2) {
        int insertPos = (q->front + q->highPriorityCount) % MSG_QUEUE_SIZE;
        q->queue[insertPos] = *msg;
        q->highPriorityCount++;
    } else {
        q->queue[q->rear] = *msg;
        q->rear = (q->rear + 1) % MSG_QUEUE_SIZE;
    }
    
    q->count++;
    return true;
}

BOOL MessageQueue_dequeue(MessageQueue* q, MSG* msg) {
    assert(q != NULL && msg != NULL);
    
    if (q->count == 0) {
        return false;
    }
    
    // Primero los mensajes de alta prioridad
    if (q->highPriorityCount > 0) {
        *msg = q->queue[q->front];
        q->front = (q->front + 1) % MSG_QUEUE_SIZE;
        q->highPriorityCount--;
    } else {
        *msg = q->queue[q->front];
        q->front = (q->front + 1) % MSG_QUEUE_SIZE;
    }
    
    q->count--;
    return true;
}

BOOL MessageQueue_peek(const MessageQueue* q, MSG* msg) {
    assert(q != NULL && msg != NULL);
    
    if (q->count == 0) {
        return false;
    }
    *msg = q->queue[q->front];
    return true;
}

void WindowSystem_init(WindowSystem* ws) {
    assert(ws != NULL);
    
    ws->heapOffset = 0;
    MessageQueue_init(&ws->msgQueue);
    ws->nextWindowId = 1;
    ws->classCount = 0;
    ws->focusWindow = NULL;
    ws->captureWindow = NULL;
    ws->activeWindow = NULL;
    ws->nextZOrder = 0;
    ws->userMessageCount = 0;
    
    memset(ws->windowInUse, 0, sizeof(ws->windowInUse));
    memset(ws->windowPool, 0, sizeof(ws->windowPool));
    memset(ws->registeredClasses, 0, sizeof(ws->registeredClasses));
    memset(ws->userMessages, 0, sizeof(ws->userMessages));
}

void* WindowSystem_allocate(WindowSystem* ws, size_t size) {
    assert(ws != NULL);
    
    if (size == 0) {
        return NULL;
    }
    
    size_t alignedSize = (size + 3) & ~3;

    if (ws->heapOffset + alignedSize > HEAP_SIZE) {
        fprintf(stderr, "Error: No hay suficiente memoria en el heap (solicitado: %zu, disponible: %zu)\n", 
                alignedSize, HEAP_SIZE - ws->heapOffset);
        return NULL;
    }

    void* ptr = &ws->fakeHeap[ws->heapOffset];
    ws->heapOffset += alignedSize;
    return ptr;
}

HWND* WindowSystem_findFreeWindowSlot(WindowSystem* ws) {
    assert(ws != NULL);
    
    for (int i = 0; i < MAX_WINDOWS; i++) {
        if (!ws->windowInUse[i]) {
            ws->windowInUse[i] = true;
            return &ws->windowPool[i];
        }
    }
    return NULL;
}

BOOL WindowSystem_registerClass(WindowSystem* ws, const WNDCLASS* wndClass) {
    assert(ws != NULL && wndClass != NULL);
    
    if (ws->classCount >= MAX_CLASSES) {
        fprintf(stderr, "Error: No se pueden registrar más clases de ventana\n");
        return false;
    }
    
    if (!wndClass->className || !*wndClass->className) {
        fprintf(stderr, "Error: Nombre de clase no válido\n");
        return false;
    }
    
    // Verificar si la clase ya está registrada
    for (int i = 0; i < ws->classCount; i++) {
        if (strcmp(ws->registeredClasses[i].className, wndClass->className) == 0) {
            fprintf(stderr, "Error: La clase '%s' ya está registrada\n", wndClass->className);
            return false;
        }
    }
    
    // Asignar memoria para el nombre de clase
    size_t classNameLen = strlen(wndClass->className) + 1;
    char* classNameCopy = (char*)WindowSystem_allocate(ws, classNameLen);
    if (!classNameCopy) {
        fprintf(stderr, "Error: No hay memoria suficiente para el nombre de clase (%zu bytes)\n", classNameLen);
        return false;
    }
    strcpy(classNameCopy, wndClass->className);
    
    // Registrar la clase
    ws->registeredClasses[ws->classCount] = *wndClass;
    ws->registeredClasses[ws->classCount].className = classNameCopy;
    ws->registeredClasses[ws->classCount].isRegistered = true;
    ws->classCount++;
    
    printf("Clase de ventana registrada: '%s'\n", classNameCopy);
    return true;
}

BOOL WindowSystem_unregisterClass(WindowSystem* ws, const char* className) {
    assert(ws != NULL && className != NULL);
    
    for (int i = 0; i < ws->classCount; i++) {
        if (strcmp(ws->registeredClasses[i].className, className) == 0) {
            // Verificar que no haya ventanas de esta clase
            bool hasWindows = false;
            for (int j = 0; j < MAX_WINDOWS; j++) {
                if (ws->windowInUse[j] && strcmp(ws->windowPool[j].className, className) == 0) {
                    hasWindows = true;
                    break;
                }
            }
            
            if (hasWindows) {
                fprintf(stderr, "Error: No se puede anular el registro de la clase '%s' porque tiene ventanas existentes\n", className);
                return false;
            }
            
            // Marcar como no registrada
            ws->registeredClasses[i].isRegistered = false;
            printf("Clase de ventana anulada: '%s'\n", className);
            return true;
        }
    }
    
    fprintf(stderr, "Error: Clase '%s' no encontrada\n", className);
    return false;
}

WNDCLASS* WindowSystem_findClass(WindowSystem* ws, const char* className) {
    assert(ws != NULL && className != NULL);
    
    for (int i = 0; i < ws->classCount; i++) {
        if (strcmp(ws->registeredClasses[i].className, className) == 0 && 
            ws->registeredClasses[i].isRegistered) {
            return &ws->registeredClasses[i];
        }
    }
    
    return NULL;
}

HWND* WindowSystem_createWindow(WindowSystem* ws, const char* className, 
                              const char* title, int x, int y, 
                              int width, int height, HWND* parent, HWND* owner, 
                              UINT style, UINT exStyle) {
    assert(ws != NULL && className != NULL && title != NULL);
    
    // Buscar la clase de ventana
    WNDCLASS* wndClass = WindowSystem_findClass(ws, className);
    if (!wndClass) {
        fprintf(stderr, "Error: Clase de ventana '%s' no registrada\n", className);
        return NULL;
    }
    
    // Validar parámetros
    if (width <= 0 || height <= 0) {
        fprintf(stderr, "Error: Dimensiones de ventana no válidas (%d x %d)\n", width, height);
        return NULL;
    }
    
    if (!wndClass->lpfnWndProc) {
        fprintf(stderr, "Error: Procedimiento de ventana no especificado\n");
        return NULL;
    }
    
    // Encontrar una ranura libre para la ventana
    HWND* hwnd = WindowSystem_findFreeWindowSlot(ws);
    if (!hwnd) {
        fprintf(stderr, "Error: No se pueden crear más ventanas. Límite de %d alcanzado\n", MAX_WINDOWS);
        return NULL;
    }

    // Asignar memoria para el título
    size_t titleLen = strlen(title) + 1;
    char* titleCopy = (char*)WindowSystem_allocate(ws, titleLen);
    if (!titleCopy) {
        // Liberar la ranura de ventana si falla la asignación
        for (int i = 0; i < MAX_WINDOWS; i++) {
            if (&ws->windowPool[i] == hwnd) {
                ws->windowInUse[i] = false;
                break;
            }
        }
        fprintf(stderr, "Error: No hay memoria suficiente para el título (%zu bytes)\n", titleLen);
        return NULL;
    }
    
    strcpy(titleCopy, title);

    // Inicializar la ventana
    *hwnd = (HWND){
        .x = x,
        .y = y,
        .width = width,
        .height = height,
        .title = titleCopy,
        .className = wndClass->className,
        .isClosed = false,
        .isVisible = (style & WS_VISIBLE) != 0,
        .isEnabled = true,
        .id = ws->nextWindowId++,
        .style = style,
        .exStyle = exStyle,
        .parent = parent,
        .owner = owner,
        .childCount = 0,
        .zOrder = ws->nextZOrder++,
        .userData = NULL,
        .background = wndClass->hbrBackground,
        .needsPaint = false,
        .updateRect = {0, 0, width, height},
        .minMaxInfo = {
            .minWidth = 100,
            .minHeight = 100,
            .maxWidth = INT_MAX,
            .maxHeight = INT_MAX
        },
        .isDialog = false,
        .isModal = false
    };

    // Agregar a la lista de hijos del padre si corresponde
    if (parent) {
        if (parent->childCount < MAX_CHILD_WINDOWS) {
            parent->children[parent->childCount++] = hwnd;
        } else {
            fprintf(stderr, "Warning: Se alcanzó el límite de ventanas hijas para la ventana padre\n");
        }
    }

    // Enviar mensaje WM_CREATE
    MSG createMsg = {WM_CREATE, 0, 0, hwnd, false};
    if (!MessageQueue_enqueue(&ws->msgQueue, &createMsg)) {
        fprintf(stderr, "Warning: No se pudo encolar mensaje WM_CREATE\n");
    }

    printf("Ventana creada con éxito: '%s' (ID: %u, Clase: %s)\n", 
           hwnd->title, hwnd->id, hwnd->className);
    
    return hwnd;
}

BOOL WindowSystem_destroyWindow(WindowSystem* ws, HWND* hwnd) {
    assert(ws != NULL && hwnd != NULL);
    
    // Enviar WM_DESTROY
    MSG destroyMsg = {WM_DESTROY, 0, 0, hwnd, false};
    WindowSystem_postMessage(ws, destroyMsg.message, destroyMsg.wParam, destroyMsg.lParam, destroyMsg.hwnd, false);
    
    // Destruir ventanas hijas primero
    for (int i = 0; i < hwnd->childCount; i++) {
        WindowSystem_destroyWindow(ws, hwnd->children[i]);
    }
    
    // Eliminar de la lista de hijos del padre
    if (hwnd->parent) {
        for (int i = 0; i < hwnd->parent->childCount; i++) {
            if (hwnd->parent->children[i] == hwnd) {
                // Mover las ventanas restantes
                for (int j = i; j < hwnd->parent->childCount - 1; j++) {
                    hwnd->parent->children[j] = hwnd->parent->children[j + 1];
                }
                hwnd->parent->childCount--;
                break;
            }
        }
    }
    
    // Liberar focus si esta ventana lo tenía
    if (ws->focusWindow == hwnd) {
        ws->focusWindow = NULL;
    }
    
    // Liberar captura si esta ventana la tenía
    if (ws->captureWindow == hwnd) {
        ws->captureWindow = NULL;
    }
    
    // Marcar la ventana como cerrada
    hwnd->isClosed = true;
    
    // Marcar la ranura como disponible
    for (int i = 0; i < MAX_WINDOWS; i++) {
        if (&ws->windowPool[i] == hwnd) {
            ws->windowInUse[i] = false;
            break;
        }
    }
    
    printf("Ventana destruida: '%s' (ID: %u)\n", hwnd->title, hwnd->id);
    return true;
}

BOOL WindowSystem_postMessage(WindowSystem* ws, UINT msg, 
                            WPARAM wParam, LPARAM lParam, HWND* hwnd, bool highPriority) {
    assert(ws != NULL);
    
    MSG message = {msg, wParam, lParam, hwnd, highPriority};
    return MessageQueue_enqueue(&ws->msgQueue, &message);
}

BOOL WindowSystem_sendMessage(WindowSystem* ws, UINT msg, 
                            WPARAM wParam, LPARAM lParam, HWND* hwnd) {
    assert(ws != NULL && hwnd != NULL);
    
    // Simulación de SendMessage: llamada directa al procedimiento de ventana
    WNDCLASS* wndClass = WindowSystem_findClass(ws, hwnd->className);
    if (!wndClass) {
        fprintf(stderr, "Error: Clase de ventana no encontrada para SendMessage\n");
        return false;
    }
    
    return wndClass->lpfnWndProc(hwnd, msg, wParam, lParam);
}

BOOL WindowSystem_getMessage(WindowSystem* ws, MSG* msg) {
    assert(ws != NULL && msg != NULL);
    return MessageQueue_dequeue(&ws->msgQueue, msg);
}

BOOL WindowSystem_peekMessage(WindowSystem* ws, MSG* msg) {
    assert(ws != NULL && msg != NULL);
    return MessageQueue_peek(&ws->msgQueue, msg);
}

BOOL WindowSystem_translateMessage(const MSG* msg) {
    // En un sistema real, esto convertiría mensajes de teclado (WM_KEYDOWN -> WM_CHAR)
    return true;
}

void WindowSystem_updateZOrder(WindowSystem* ws, HWND* hwnd) {
    assert(ws != NULL && hwnd != NULL);
    
    // Actualizar el z-order solo si es necesario
    if (hwnd->zOrder < ws->nextZOrder) {
        hwnd->zOrder = ws->nextZOrder++;
    }
}

void WindowSystem_bringToTop(WindowSystem* ws, HWND* hwnd) {
    assert(ws != NULL && hwnd != NULL);
    
    hwnd->zOrder = ws->nextZOrder++;
    
    // Si tiene owner, traerlo también al frente
    if (hwnd->owner) {
        WindowSystem_bringToTop(ws, hwnd->owner);
    }
}

void WindowSystem_setFocus(WindowSystem* ws, HWND* hwnd) {
    assert(ws != NULL);
    
    if (ws->focusWindow == hwnd) {
        return;
    }
    
    // Enviar WM_KILLFOCUS a la ventana actual
    if (ws->focusWindow) {
        WindowSystem_postMessage(ws, WM_KILLFOCUS, (WPARAM)hwnd, 0, ws->focusWindow, false);
    }
    
    // Actualizar el foco
    ws->focusWindow = hwnd;
    
    // Enviar WM_SETFOCUS a la nueva ventana
    if (hwnd) {
        WindowSystem_postMessage(ws, WM_SETFOCUS, (WPARAM)ws->focusWindow, 0, hwnd, false);
    }
}

void WindowSystem_setCapture(WindowSystem* ws, HWND* hwnd) {
    assert(ws != NULL);
    ws->captureWindow = hwnd;
}

void WindowSystem_releaseCapture(WindowSystem* ws) {
    assert(ws != NULL);
    ws->captureWindow = NULL;
}

HWND* WindowSystem_getCapture(WindowSystem* ws) {
    assert(ws != NULL);
    return ws->captureWindow;
}

void WindowSystem_setActiveWindow(WindowSystem* ws, HWND* hwnd) {
    assert(ws != NULL);
    
    if (ws->activeWindow == hwnd) {
        return;
    }
    
    // Enviar WM_ACTIVATE a las ventanas afectadas
    if (ws->activeWindow) {
        WindowSystem_postMessage(ws, WM_ACTIVATE, WA_INACTIVE, 0, ws->activeWindow, false);
    }
    
    ws->activeWindow = hwnd;
    
    if (hwnd) {
        WindowSystem_postMessage(ws, WM_ACTIVATE, WA_ACTIVE, 0, hwnd, false);
        WindowSystem_bringToTop(ws, hwnd);
        WindowSystem_setFocus(ws, hwnd);
    }
}

HWND* WindowSystem_getActiveWindow(WindowSystem* ws) {
    assert(ws != NULL);
    return ws->activeWindow;
}

void WindowSystem_invalidateRect(WindowSystem* ws, HWND* hwnd, const RECT* rect, bool erase) {
    assert(ws != NULL && hwnd != NULL);
    
    if (rect) {
        // Combinar el rectángulo inválido con el existente
        hwnd->updateRect.left = min(hwnd->updateRect.left, rect->left);
        hwnd->updateRect.top = min(hwnd->updateRect.top, rect->top);
        hwnd->updateRect.right = max(hwnd->updateRect.right, rect->right);
        hwnd->updateRect.bottom = max(hwnd->updateRect.bottom, rect->bottom);
    } else {
        // Invalidar toda la ventana
        hwnd->updateRect.left = 0;
        hwnd->updateRect.top = 0;
        hwnd->updateRect.right = hwnd->width;
        hwnd->updateRect.bottom = hwnd->height;
    }
    
    hwnd->needsPaint = true;
    
    // Encolar mensaje WM_PAINT si no hay uno pendiente
    bool hasPaintMsg = false;
    MSG msg;
    for (int i = 0; i < ws->msgQueue.count; i++) {
        int idx = (ws->msgQueue.front + i) % MSG_QUEUE_SIZE;
        if (ws->msgQueue.queue[idx].hwnd == hwnd && ws->msgQueue.queue[idx].message == WM_PAINT) {
            hasPaintMsg = true;
            break;
        }
    }
    
    if (!hasPaintMsg) {
        WindowSystem_postMessage(ws, WM_PAINT, 0, 0, hwnd, false);
    }
}

void WindowSystem_updateWindow(WindowSystem* ws, HWND* hwnd) {
    assert(ws != NULL && hwnd != NULL);
    
    if (hwnd->needsPaint) {
        MSG paintMsg = {WM_PAINT, 0, 0, hwnd, true}; // Alta prioridad
        MessageQueue_enqueue(&ws->msgQueue, &paintMsg);
    }
}

void WindowSystem_redrawWindow(WindowSystem* ws, HWND* hwnd, const RECT* rect, bool erase) {
    WindowSystem_invalidateRect(ws, hwnd, rect, erase);
    WindowSystem_updateWindow(ws, hwnd);
}

UINT WindowSystem_registerUserMessage(WindowSystem* ws) {
    assert(ws != NULL);
    
    if (ws->userMessageCount >= MAX_USER_MESSAGES) {
        fprintf(stderr, "Error: No se pueden registrar más mensajes de usuario\n");
        return 0;
    }
    
    UINT msg = WM_USER + ws->userMessageCount + 1;
    ws->userMessages[ws->userMessageCount++] = msg;
    return msg;
}

LRESULT DefWindowProc(HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    assert(hwnd != NULL);
    
    switch (msg) {
        case WM_CLOSE:
            hwnd->isClosed = true;
            printf("Ventana '%s' (ID: %u) recibió mensaje WM_CLOSE\n", 
                  hwnd->title, hwnd->id);
            return 0;
            
        case WM_DESTROY:
            printf("Ventana '%s' (ID: %u) recibió mensaje WM_DESTROY\n",
                  hwnd->title, hwnd->id);
            return 0;
            
        case WM_PAINT: {
            HDC hdc = BeginPaint(hwnd, &hwnd->updateRect);
            if (hdc.hwnd) {
                // Lógica de pintado aquí
                printf("Repintando ventana '%s' (rect: %d,%d-%d,%d)\n", 
                      hwnd->title, hwnd->updateRect.left, hwnd->updateRect.top,
                      hwnd->updateRect.right, hwnd->updateRect.bottom);
                
                // Ejemplo: dibujar un borde
                HDC_rectangle(&hdc, 0, 0, hwnd->width - 1, hwnd->height - 1);
                
                // Ejemplo: dibujar texto centrado
                const char* text = hwnd->title;
                int textLen = strlen(text);
                int textX = (hwnd->width - textLen * 8) / 2; // Aproximación
                int textY = (hwnd->height - 16) / 2;
                HDC_textOut(&hdc, textX, textY, text, textLen);
                
                EndPaint(hwnd, &hdc);
            }
            return 0;
        }
            
        case WM_SIZE: {
            int newWidth = LOWORD(lParam);
            int newHeight = HIWORD(lParam);
            printf("Ventana '%s' cambiada de tamaño a %dx%d\n", hwnd->title, newWidth, newHeight);
            hwnd->width = newWidth;
            hwnd->height = newHeight;
            return 0;
        }
            
        case WM_MOVE: {
            int newX = (int)(short)LOWORD(lParam);
            int newY = (int)(short)HIWORD(lParam);
            printf("Ventana '%s' movida a (%d,%d)\n", hwnd->title, newX, newY);
            hwnd->x = newX;
            hwnd->y = newY;
            return 0;
        }
            
        case WM_GETMINMAXINFO: {
            MINMAXINFO* info = (MINMAXINFO*)lParam;
            *info = hwnd->minMaxInfo;
            return 0;
        }
            
        case WM_COMMAND:
            printf("Ventana '%s' recibió comando: %d\n", hwnd->title, LOWORD(wParam));
            return 0;
            
        case WM_KEYDOWN:
            printf("Tecla presionada: 0x%02X\n", (UINT)wParam);
            return 0;
            
        case WM_CHAR:
            printf("Carácter ingresado: '%c'\n", (char)wParam);
            return 0;
            
        case WM_LBUTTONDOWN:
            printf("Clic izquierdo en (%d,%d)\n", 
                  (int)(short)LOWORD(lParam), (int)(short)HIWORD(lParam));
            return 0;
            
        default:
            if (msg >= WM_USER && msg <= 0x7FFF) {
                printf("Mensaje de usuario 0x%04X recibido en ventana '%s'\n", msg, hwnd->title);
                return 0;
            }
            
            printf("Mensaje no manejado: 0x%04X en ventana '%s' (ID: %u)\n", 
                  msg, hwnd->title, hwnd->id);
            return 0;
    }
}

HDC BeginPaint(HWND* hwnd, RECT* updateRect) {
    assert(hwnd != NULL && updateRect != NULL);
    
    if (hwnd->isClosed) {
        fprintf(stderr, "Error: No se puede pintar en una ventana cerrada\n");
        return (HDC){NULL, 0, NULL, NULL, NULL, {0,0,0,0}, false, NULL};
    }

    // Copiar el rectángulo de actualización
    *updateRect = hwnd->updateRect;
    
    // Resetear el estado de pintado
    hwnd->needsPaint = false;
    hwnd->updateRect.left = hwnd->updateRect.top = INT_MAX;
    hwnd->updateRect.right = hwnd->updateRect.bottom = INT_MIN;
    
    return (HDC){
        .hwnd = hwnd,
        .currentColor = 0x00000000, 
        .currentBrush = hwnd->background,
        .currentPen = NULL,
        .currentFont = NULL,
        .clipRect = *updateRect,
        .doubleBuffer = false,
        .bufferBitmap = NULL
    };
}

void EndPaint(HWND* hwnd, HDC* hdc) {
    assert(hwnd != NULL && hdc != NULL);
    // En un sistema real, esto liberaría recursos del HDC
}

LRESULT DispatchMessage(WindowSystem* ws, const MSG* msg) {
    assert(ws != NULL && msg != NULL);
    
    if (!msg->hwnd || msg->hwnd->isClosed) {
        printf("Warning: Mensaje enviado a ventana cerrada o no válida\n");
        return 0;
    }

    WNDCLASS* wndClass = WindowSystem_findClass(ws, msg->hwnd->className);
    if (!wndClass) {
        fprintf(stderr, "Error: No hay procedimiento de ventana definido para la clase '%s'\n", 
               msg->hwnd->className);
        return -1;
    }

    return wndClass->lpfnWndProc(msg->hwnd, msg->message, msg->wParam, msg->lParam);
}

void WindowSystem_handleSizeMove(WindowSystem* ws, HWND* hwnd, int newWidth, int newHeight, int newX, int newY) {
    assert(ws && hwnd);
    
    if (newWidth != hwnd->width || newHeight != hwnd->height) {
        hwnd->width = newWidth;
        hwnd->height = newHeight;
        WindowSystem_postMessage(ws, WM_SIZE, SIZE_RESTORED, 
                               MAKELPARAM(newWidth, newHeight), hwnd, false);
        WindowSystem_invalidateRect(ws, hwnd, NULL, true);
    }
    
    if (newX != hwnd->x || newY != hwnd->y) {
        hwnd->x = newX;
        hwnd->y = newY;
        WindowSystem_postMessage(ws, WM_MOVE, 0, 
                               MAKELPARAM(newX, newY), hwnd, false);
    }
}

void WindowSystem_handleMinMaxInfo(WindowSystem* ws, HWND* hwnd, MINMAXINFO* info) {
    assert(ws && hwnd && info);
    *info = hwnd->minMaxInfo;
}

void WindowSystem_handleCommand(WindowSystem* ws, HWND* hwnd, WPARAM wParam, LPARAM lParam) {
    assert(ws && hwnd);
    WindowSystem_postMessage(ws, WM_COMMAND, wParam, lParam, hwnd, false);
}

void WindowSystem_handleKeyboard(WindowSystem* ws, HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    assert(ws && hwnd);
    
    // En un sistema real, aquí habría más lógica para manejar el teclado
    WindowSystem_postMessage(ws, msg, wParam, lParam, hwnd, false);
    
    // Convertir WM_KEYDOWN a WM_CHAR si es necesario
    if (msg == WM_KEYDOWN) {
        // Simulación simple: convertir a carácter mayúscula
        char ch = (char)wParam;
        if (ch >= 'A' && ch <= 'Z') {
            WindowSystem_postMessage(ws, WM_CHAR, (WPARAM)ch, lParam, hwnd, false);
        }
    }
}

void WindowSystem_handleMouse(WindowSystem* ws, HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    assert(ws && hwnd);
    
    // Determinar la ventana objetivo (captura o bajo el cursor)
    HWND* target = ws->captureWindow ? ws->captureWindow : hwnd;
    
    // Convertir coordenadas si es necesario
    int x = (int)(short)LOWORD(lParam);
    int y = (int)(short)HIWORD(lParam);
    
    // Enviar el mensaje
    WindowSystem_postMessage(ws, msg, wParam, MAKELPARAM(x, y), target, false);
    
    // Cambiar el foco si es un clic
    if (msg == WM_LBUTTONDOWN) {
        WindowSystem_setFocus(ws, target);
    }
}

// Ejemplo de procedimiento de ventana personalizado
LRESULT CustomWindowProc(HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    switch (msg) {
        case WM_PAINT: {
            RECT updateRect;
            HDC hdc = BeginPaint(hwnd, &updateRect);
            if (hdc.hwnd) {
                // Dibujar un fondo azul
                HDC_textOut(&hdc, 10, 10, "Esta es una ventana personalizada", 32);
                EndPaint(hwnd, &hdc);
            }
            return 0;
        }
        case WM_CLOSE:
            printf("Ventana personalizada cerrada\n");
            hwnd->isClosed = true;
            return 0;
        default:
            return DefWindowProc(hwnd, msg, wParam, lParam);
    }
}

int main() {
    WindowSystem ws;
    WindowSystem_init(&ws);
    
    // Registrar clase de ventana principal
    WNDCLASS mainClass = {
        .lpfnWndProc = DefWindowProc,
        .className = "MainWindowClass",
        .style = CS_VREDRAW | CS_HREDRAW,
        .hbrBackground = (HBRUSH)1, // Simular brush blanco
        .hFont = NULL
    };
    WindowSystem_registerClass(&ws, &mainClass);
    
    // Registrar clase de ventana personalizada
    WNDCLASS customClass = {
        .lpfnWndProc = CustomWindowProc,
        .className = "CustomWindowClass",
        .style = CS_VREDRAW | CS_HREDRAW,
        .hbrBackground = (HBRUSH)2, // Simular brush azul
        .hFont = NULL
    };
    WindowSystem_registerClass(&ws, &customClass);
    
    // Crear la ventana principal
    HWND* mainWnd = WindowSystem_createWindow(&ws, "MainWindowClass", 
                                           "Ventana Principal", 100, 100, 
                                           600, 400, NULL, NULL, 
                                           WS_OVERLAPPEDWINDOW | WS_VISIBLE, 0);
    
    // Crear una ventana hija (botón)
    HWND* buttonWnd = WindowSystem_createWindow(&ws, "MainWindowClass", 
                                             "Botón", 50, 50, 
                                             100, 30, mainWnd, NULL, 
                                             WS_CHILD | WS_VISIBLE, 0);
    
    // Crear una ventana personalizada
    HWND* customWnd = WindowSystem_createWindow(&ws, "CustomWindowClass", 
                                             "Ventana Personalizada", 200, 200, 
                                             300, 200, NULL, mainWnd, 
                                             WS_OVERLAPPEDWINDOW | WS_VISIBLE, 0);
    
    // Registrar un mensaje de usuario
    UINT userMsg = WindowSystem_registerUserMessage(&ws);
    printf("Mensaje de usuario registrado: 0x%04X\n", userMsg);
    
    // Bucle principal de mensajes
    MSG msg;
    while (WindowSystem_getMessage(&ws, &msg)) {
        WindowSystem_translateMessage(&msg);
        LRESULT result = DispatchMessage(&ws, &msg);
        
        if (msg.message == WM_CLOSE) {
            printf("Ventana cerrada. Resultado: %ld\n", result);
            WindowSystem_destroyWindow(&ws, msg.hwnd);
            
            // Salir si se cierra la ventana principal
            if (msg.hwnd == mainWnd) {
                break;
            }
        }
        
        // Simular entrada de usuario
        static int clickCount = 0;
        if (msg.hwnd == buttonWnd && msg.message == WM_LBUTTONDOWN) {
            printf("Botón clickeado! (%d veces)\n", ++clickCount);
            
            // Enviar mensaje de usuario a la ventana principal
            if (userMsg != 0) {
                WindowSystem_postMessage(&ws, userMsg, clickCount, (LPARAM)buttonWnd, mainWnd, false);
            }
        }
    }

    return 0;
}