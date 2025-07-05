#ifndef WINDOW_SYSTEM_DEFS_H
#define WINDOW_SYSTEM_DEFS_H

#include <assert.h>
#include <limits.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Estilos de ventana
#define WS_OVERLAPPED 0x00000000L
#define WS_POPUP 0x80000000L
#define WS_CHILD 0x40000000L
#define WS_VISIBLE 0x10000000L
#define WS_DISABLED 0x08000000L
#define WS_CAPTION 0x00C00000L
#define WS_SYSMENU 0x00080000L
#define WS_THICKFRAME 0x00040000L
#define WS_MINIMIZEBOX 0x00020000L
#define WS_MAXIMIZEBOX 0x00010000L
// Estilos extendidos
#define WS_EX_TOPMOST 0x00000008L

// Controles del sistema
#define MAX_WINDOS 50
#define HEAP_SIZE 4096
#define MAX_CLASSES 10
#define MAX_USER_MESSAGES 100
#define MAX_CHILD_WINDOWS 10

// Mensajes estándar
#define WM_NULL 0x0000
#define WM_CREATE 0x0001
#define WM_DESTROY 0x0002
#define WM_MOVE 0x0003
#define WM_SIZE 0x0005
#define WM_ACTIVATE 0x0006
#define WM_SETFOCUS 0x0007
#define WM_KILLFOCUS 0x0008
#define WM_PAINT 0x000F
#define WM_CLOSE 0x0010
#define WM_QUIT 0x0012
#define WM_ERASEBKGND 0x0014
#define WM_SHOWWINDOW 0x0018
#define WM_GETMINMAXINFO 0x0024
#define WM_WINDOWPOSCHANGING 0x0046
#define WM_WINDOWPOSCHANGED 0x0047
#define WM_COMMAND 0x0111
#define WM_KEYDOWN 0x0100
#define WM_KEYUP 0x0101
#define WM_CHAR 0x0102
#define WM_MOUSEMOVE 0x0200
#define WM_LBUTTONDOWN 0x0201
#define WM_LBUTTONUP 0x0202
#define WM_RBUTTONDOWN 0x0204
#define WM_MOUSEWHEEL 0x020A
#define WM_USER 0x0400

#define MAX_WINDOS 50
#define HEAP_SIZE 4096
#define MSG_QUEUE_SIZE 128
#define MAX_CLASSES 10
#define MAX_USER_MESSAGES 100
#define MAX_CHILD_WINDOWS 10

#endif