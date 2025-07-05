#include "../include/window_system.h"
#include "../include/message_queue.h"

LRESULT CustomWindowProc(HWND* hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
   switch (msg) {
    case WM_PAINT: {

    }
   }
}

int main() {
    WindowSystem ws;
    WindowSystem_init(&ws);

    WNDCLASS mainClass = {
        .lpfnWndProc = DefWindowProc,
        .className = "Ventana Principal",
        .style = CS_VREDDRAW | CS_HREDDRAW;
    }
    return 0;
}