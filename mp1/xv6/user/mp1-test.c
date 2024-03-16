#include "kernel/types.h"
#include "user/user.h"
#include "user/threads.h"

#define NULL 0

void f1(void *arg)
{
    int i = 100;

    while(1) {
        printf("thread 1: %d\n", i++);
        if (i == 110) {
            thread_exit();
        }
        thread_yield();
    }
}

int main(int argc, char **argv)
{
    struct thread *t1 = thread_create(f1, NULL);
    thread_add_runqueue(t1);
    thread_start_threading();
    printf("\nexited\n");
    exit(0);
}
