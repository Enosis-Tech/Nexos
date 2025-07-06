#ifndef WINDOW_HANDLES_H
#define WINDOW_HANDLES_H

#include "window_system.h"
#include "message_queue.h"
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

// Prototipos de funciones
HWND* WindowSystem_createWindow(WindowSystem* ws, const WNDCLASS* wndClass, const char* className, const char* title, int x, int y, int width, int height, HWND* parent, HWND* owner, UINT style, UINT esStyle);
HWND* WindowSystem_findFreeWindowSlot(WindowSystem* ws);
HWND* WindowSystem_getCapture(WindowSystem* ws);
HWND* WindowSystem_getActiveWindow(WindowSystem* ws);
BOOL WindowSystem_destroyWindow(WindowSystem* ws, HWND* hwnd);
BOOL WindowSystem_postMessage(WindowSystem* ws, UINT msg, WPARAM wParam, LPARAM lParam, HWND* hwnd, bool highPriority);
BOOL WindowSystem_sendMessage(WindowSystem* ws, UINT msg, WPARAM wParam, LPARAM lParam, HWND* hwnd);
BOOL WindowSystem_getMessage(WindowSystem* ws, MSG* msg);
BOOL WindowSystem_peekMessage(WindowSystem* ws, MSG* msg);
BOOL WindowSystem_registerClass(WindowSystem* ws, const WNDCLASS* wndClass);
BOOL WindowSystem_unregisterClass(WindowSystem* ws, const char* className);
WNDCLASS* WindowSystem_findClass(WindowSystem* ws, const char* className);
UINT WindowSystem_registerUserMessage(WindowSystem* ws);
LRESULT DefWindowProc(HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
void WindowSystem_updateZOrder(WindowSystem* ws, HWND* hwnd);
void WindowSystem_bringToTop(WindowSystem* ws, HWND* hwnd);
void WindowSystem_setFocus(WindowSystem* ws, HWND* hwnd);
void WindowSystem_setCapture(WindowSystem* ws, HWND* hwnd);
void WindowSystem_releaseCapture(WindowSystem* ws);
void WindowSystem_setActiveWindow(WindowSystem* ws, HWND* hwnd);
void WindowSystem_invalidateRect(WindowSystem* ws, HWND* hwnd, const RECT* rect, bool erase);
void WindowSystem_updateWindow(WindowSystem* ws, HWND* hwnd);
void WindowSystem_redrawWindow(WindowSystem* ws, HWND* hwnd, const RECT* rect, bool erase);
void WindowSystem_handleSizeMove(WindowSystem* ws, HWND* hwnd, int newWidth, int newHeight, int newX, int newY);
void WindowSystem_handleMinMaxInfo(WindowSystem* ws, HWND* hwnd, MINMAXINFO* info);
void WindowSystem_handleCommand(WindowSystem* ws, HWND* hwnd, WPARAM wParam, LPARAM lParam);
void WindowSystem_handleKeyboard(WindowSystem* ws, HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
void WindowSystem_handleMouse(WindowSystem* ws, HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam);

BOOL WindowSystem_translateMessage(const MSG* msg); // Para versiones futuras, si es que se continua vea :v
#endif