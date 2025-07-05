#ifndef WINDOW_SYSTEM_GDI_H
#define WINDOW_SYSTEM_GDI_H

#include "window_handles.h"
#include "window_system.h"

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

HDC BeginPaint(HWND* hwnd, RECT* updateRect);
void EndPaint(HWND* hwnd, HDC* hdc);
void HDC_rectangle(HDC* hdc, int left, int top, int right, int bottom);
void HDC_textOut(HDC* hdc, int x, int y, const char* text, int length);

#endif