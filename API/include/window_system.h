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
typedef void*HFONT; 
typedef void* HBITMAP;
typedef void* HBRUSH;
typedef unsigned int UINT;
typedef unsigned long WPARAM;
typedef unsigned long COLORREF;

// Estructura principal del sistema de ventanas
typedef struct WindowSystem WindowSystem;

// Prototipos de funciones
// BOOL WindowSystem_registerClass(WindowSystem* ws, const void* wndClass);
// BOOL WindowSystem_unregisterClass(WindowSystem* ws, const char* className);

// BOOL WindowSystem_getMessage(WindowSystem* ws, MSG* msg);



#endif