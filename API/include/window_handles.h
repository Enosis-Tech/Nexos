#ifndef WINDOW_HANDLES_H
#define WINDOW_HANDLES_H

#include "window_system.h"
#include "defs.h"


// Estructura para la región
typedef struct {
    int top;
    int left;
    int right;
    int bottom;
} RECT;

// Estructura para mínimo y máximo
typedef struct {
    int minWidth;
    int minHeight;
    int maxWidth;
    int maxHeight;
} MINMAXINFO;


// Estructura de la ventana
typedef struct HWND__ {
    int x, y, width, height, childCount, zOrder;
    char *title;
    bool isClosed, isVisible, isEnabled, needsPaint, isDialog, isModal;
    void *userData;
    HBRUSH background;
    MINMAXINFO minMaxInfo;
    RECT updateRect;
    UINT id;
    UINT style;
    UINT exStyle;
    const char *className;
    struct HWND__ *parent;
    struct HWND__ *owner;
    struct HWND__ *children[MAX_CHILD_WINDOWS];
} HWND;
#endif