#ifndef WINDOW_SYSTEM_MESSAGE_QUEUE_H
#define WINDOW_SYSTEM_MESSAGE_QUEUE_H

#include "window_system.h"

#define MSG_QUEUE_SIZE 128

// Estrunctura del mensaje
typedef struct { 
    UINT message;
    WPARAM wParam;
    LPARAM lParam;
    struct HWND__* hwnd;
    bool isHightPriority;
} MSG;

// Cola de mensajes
typedef struct {
    MSG queue[MSG_QUEUE_SIZE];
    int front;
    int rear;
    int count;
    int highPriorityCount;
} MessageQueue;

void MessageQueue_init(MessageQueue* q);
BOOL MessageQueue_enqueue(MessageQueue* q, const MSG* msg);
BOOL MessageQueue_dequeue(MessageQueue* q, MSG* msg);
BOOL MessageQueue_peek(const MessageQueue* q, MSG* msg);
#endif