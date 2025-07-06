#ifndef WINDOW_SYSTEM_H
#define WINDOW_SYSTEM_H

#include "defs.h"
#include <stdbool.h>
#include <stdint.h>
#include <limits.h>

// Definición de tipos básicos
typedef long LRESULT;
typedef long LPARAM;
typedef int BOOL;
typedef void* HPEN;
typedef void* HFONT; 
typedef void* HBITMAP;
typedef void* HBRUSH;
typedef unsigned int UINT;
typedef unsigned long WPARAM;
typedef unsigned long COLORREF;

// Estructura principal del sistema de ventanas
typedef struct WindowSystem WindowSystem;
typedef LRESULT (*WNDPROC)(struct HWND__ *, UINT, WPARAM, LPARAM);

// Clase de ventana registrada
typedef struct {
    WNDPROC lpfnWndProc;
    const char *className;
    UINT style;
    HBRUSH hbrBackground;
    HFONT hFont;
    bool isRegistered;
} WNDCLASS;

// Prototipos de funciones
void WindowSystem_init(WindowSystem* ws);
void* WindowSystem_allocate(WindowSystem* ws, size_t size);
BOOL WindowSystem_registerClass(WindowSystem* ws, const WNDCLASS* wndClass);
BOOL WindowSystem_unregisterClass(WindowSystem* ws, const char* className);
#endif