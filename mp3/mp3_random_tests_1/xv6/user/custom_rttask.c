#include "kernel/types.h"
          #include "user/user.h"
          #include "user/threads.h"
          #define NULL 0
          int k = 0;
          void f(void *arg){
              while (1) k++;
          }
          int main(int argc, char **argv){
          struct thread *t1 = thread_create(f, NULL, 1, 9, 54, 10);
thread_set_weight(t1, 1);
thread_add_at(t1, 64);
struct thread *t2 = thread_create(f, NULL, 1, 3, 5, 8);
thread_set_weight(t2, 1);
thread_add_at(t2, 74);
thread_start_threading();
          printf("\nexited\n");
          exit(0);
          }