#include "../include/message_queue.h"
#include <assert.h>

void MessageQueue_init(MessageQueue *q) {
    assert(q != NULL);
    q->front = 0;
    q->rear = 0;
    q->count = 0;
    q->highPriorityCount = 0;
}

BOOL MessageQueue_enqueue(MessageQueue *q, const MSG *msg) {
    assert(q != NULL && msg != NULL);

    if (q->count >= MSG_QUEUE_SIZE) return false;
    if (msg->isHightPriority && q->highPriorityCount < MSG_QUEUE_SIZE / 2) {
        int insertPost = (q->front + q->highPriorityCount) % MSG_QUEUE_SIZE;
        q->queue[insertPost] = *msg;
        q->highPriorityCount++;
    } else {
        q->queue[q->rear] = *msg;
        q->rear = (q->rear + 1) % MSG_QUEUE_SIZE;
    }
    q->count++;
    return true;
}

BOOL MessageQueue_dequeue(MessageQueue* q, MSG* msg) {
    assert(q != NULL && msg != NULL);
    if (q->count == 0) return false;
    if (q->highPriorityCount > 0) {
        *msg = q->queue[q->front];
        q->front = (q->front + 1) % MSG_QUEUE_SIZE;
        q->highPriorityCount++;
    } else {
        *msg = q->queue[q->front];
        q->front = (q->front + 1) % MSG_QUEUE_SIZE;
    }
    q->count--;
    return true;
}

BOOL MessageQueue_peek(MessageQueue* q, MSG* msg) {
    assert(q != NULL && msg != NULL);
    if (q->count == 0) return false;
    *msg = q->queue[q->front];
    return true;
}