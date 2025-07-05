#ifndef WINDOW_SYSTEM_WINDOW_CLASS_H
#define WINDOW_SYSTEM_WINDOW_CLASS_H

#include "window_system.h"

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

#endif