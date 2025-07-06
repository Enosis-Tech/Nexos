#include "../include/window_system.h"
#include "../include/message_queue.h"
#include "../include/window_class.h"
#include "../include/window_handles.h"
#include <string.h>
#include <stdlib.h>
#include <assert.h>

struct WindowSystem {
    bool windowsInUse[MAX_WINDOS];
    WNDCLASS registeredClasses[MAX_CLASSES];
    int classCount;
    int nextZOrder;
    int userMessageCount;
    char fakeHeap[HEAP_SIZE];
    size_t heapOffset;
    MessageQueue msgQueue;
    UINT nextWindowId;
    UINT userMessage[MAX_USER_MESSAGES];
    HWND windowPool[MAX_WINDOS];
    HWND* focusWindow;
    HWND* captureWindow;
    HWND* activeWindow;
};

void WindowSystem_init(WindowSystem *ws) {
    assert(ws != NULL);

    MessageQueue_init(&ws->msgQueue);
    ws->heapOffset = 0;
    ws->nextWindowId = 0;
    ws->userMessageCount = 0;
    ws->nextZOrder = 0;
    ws->focusWindow = NULL;
    ws->captureWindow = NULL;
    ws->activeWindow = NULL;

    memset(ws->windowsInUse, 0, sizeof(ws->windowsInUse));
    memset(ws->windowPool, 0, sizeof(ws->windowPool));
    memset(ws->registeredClasses, 0, sizeof(ws->registeredClasses));
    memset(ws->userMessage, 0, sizeof(ws->userMessage));
}


void* WindowsSystem_allocate(WindowSystem* ws, size_t size) {
    assert(ws != NULL);

    if (size == 0) return NULL;
    
    size_t alingedSize = (size + 3) & ~3;

    if (ws->heapOffset + alingedSize > HEAP_SIZE) return NULL;

    void* ptr = &ws->fakeHeap[ws->heapOffset];
    ws->heapOffset += alingedSize;
    return ptr;
}