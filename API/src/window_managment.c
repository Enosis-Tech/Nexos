#include "../include/defs.h"
#include "../include/message_queue.h"
#include "../include/window_class.h"
#include "../include/window_handles.h"
#include "../include/window_system.h"
#include "window_system.c"
#include <string.h>
#include <stdio.h>
#include <assert.h>
#include <time.h>
#include <vcruntime.h>

HWND* WindowSystem_createWindow(WindowSystem* ws, const WNDCLASS* wndClass, const char* className, const char* title, int x, int y, int width, int height, HWND* parent, HWND* owner, UINT style, UINT esStyle) {
    assert(ws != NULL && wndClass != NULL && title != NULL);

    // Buscar clase de ventana
    WNDCLASS* wndclass = WindowSystem_findClass(ws, className);
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

    // Tratamos de encontrar un espacio libre para nueva ventana alv
    HWND* hwnd = WindowSystem_findFreeWindowSlot(ws);
    if (!hwnd) {
        fprintf(stderr, "Error: No se pueden crear más ventanas. Límite  de '%d' ventanas alcanzado\n", MAX_WINDOS);
        return NULL;
    }

    // Asiganr memoria para el título alv
    size_t titleLen = strlen(title) + 1;
    char* titleCopy = (char*)WindowSystem_allocate(ws, titleLen);
    if (!titleCopy) {
        // Liberar la "ranura" o el espacio de la ventana por si falla la asignación
        for (int i = 0; i < MAX_WINDOS; i++) {
            if (&ws->windowPool[i] == hwnd) {
                ws->windowsInUse[i] = false;
                break;
            }
        }
        fprintf(stderr, "Error: No hay memoria suficiente para el título (%zu bytes)\n", titleLen);
        return NULL;
    }
}

HWND* WindowSystem_findFreeWindowSlot(WindowSystem* ws) {
    assert(ws != NULL);
    for (int i = 0; i < MAX_CHILD_WINDOWS; i++) {
        if(!ws->windowsInUse[i]) {
            ws->windowsInUse[i] = true;
            return &ws->windowPool[i];
        }
    }
    return NULL;
}

BOOL WindowSystem_unregisterClass(WindowSystem *ws, const char *className) {
    assert((ws != NULL && className != NULL));
    for(int i = 0; i < ws->classCount; i++) {
        if(strcmp(ws->registeredClasses[i].className, className) == 0) {
            // Ver si no hay ventanas en la clase
            bool hasWindows = false;
            for (int j = 0; j < MAX_WINDOS; j++) {
                if(ws->windowsInUse[j] && strcmp(ws->windowPool[j].className, className) == 0) {
                    hasWindows = true;
                    break;
                }
            }
            if (hasWindows) {
                fprintf(stderr, "Error: No se pued anular el registro de la clase '%s' porque tiene ventanas existentes\n", className);
                return true;
            }
        }
    }
    fprintf(stderr, "Error: Clase '%s' no encontrada\n", className);
    return false;
}

BOOL WindowSystem_registerClass(WindowSystem *ws, const WNDCLASS *wndClass) {
    assert(ws != NULL && wndClass != NULL);
    if(ws->classCount >= MAX_CLASSES) {
        fprintf(stderr, "Error: No se peuden registar más clases de ventana\n");
        return false;
    }
    if(!wndClass->className || !*wndClass->className) {
        fprintf(stderr, "Error: Nombre de clase no válido\n");
        return false;
    }

    // Verificar si ya existe
    for(int i = 0; i <ws->classCount; i++) {
        if(strcmp(ws->registeredClasses[i].className, wndClass->className) == 0) {
            fprintf(stderr, "Error: La clase '%s' ya está registrada\n", wndClass->className);
            return false;
        }
    }

    // Asignar memoria para le nombre de clase
    size_t classNameLen = strlen(wndClass->className) + 1;
    char* classNameCopy = (char*)WindowSystem_allocate(ws, classNameLen);
    if(!classNameCopy) {
        fprintf(stderr, "Error: No hay memoria suficiente para el nombre de clase (%zu bytes)\n", classNameLen);
        return false;
    }
    strcpy(classNameCopy, wndClass->className);
    // Registar clase
    ws->registeredClasses[ws->classCount] = *wndClass;
    ws->registeredClasses[ws->classCount].className = classNameCopy;
    ws->registeredClasses[ws->classCount].isRegistered = true;
    ws->classCount++;

    printf("Clase de la ventana registrada :)");
    return true;
}

WNDCLASS* WindowSystem_findClass(WindowSystem* ws, const char* className) {
    assert(ws != NULL && className != NULL);
    for (int i = 0; i < ws->classCount; i++) {
        if (ws->registeredClasses[i].isRegistered) {
            return &ws->registeredClasses[i];
        }
    }
    return NULL;
}