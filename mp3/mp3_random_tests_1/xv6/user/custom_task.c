#include "kernel/types.h"
          #include "user/user.h"
          #include "user/threads.h"
          #define NULL 0
          int k = 0;
          void f(void *arg){
              while (1) k++;
          }
          int main(int argc, char **argv){
          struct thread *t1 = thread_create(f, NULL, 0, 13, -1, 1);
thread_set_weight(t1, 4);
thread_add_at(t1, 67);
struct thread *t2 = thread_create(f, NULL, 0, 44, -1, 1);
thread_set_weight(t2, 1);
thread_add_at(t2, 30);
struct thread *t3 = thread_create(f, NULL, 0, 14, -1, 1);
thread_set_weight(t3, 2);
thread_add_at(t3, 97);
struct thread *t4 = thread_create(f, NULL, 0, 6, -1, 1);
thread_set_weight(t4, 2);
thread_add_at(t4, 72);
struct thread *t5 = thread_create(f, NULL, 0, 16, -1, 1);
thread_set_weight(t5, 4);
thread_add_at(t5, 6);
struct thread *t6 = thread_create(f, NULL, 0, 23, -1, 1);
thread_set_weight(t6, 2);
thread_add_at(t6, 67);
struct thread *t7 = thread_create(f, NULL, 0, 59, -1, 1);
thread_set_weight(t7, 3);
thread_add_at(t7, 96);
struct thread *t8 = thread_create(f, NULL, 0, 27, -1, 1);
thread_set_weight(t8, 2);
thread_add_at(t8, 100);
struct thread *t9 = thread_create(f, NULL, 0, 20, -1, 1);
thread_set_weight(t9, 2);
thread_add_at(t9, 15);
struct thread *t10 = thread_create(f, NULL, 0, 13, -1, 1);
thread_set_weight(t10, 4);
thread_add_at(t10, 75);
struct thread *t11 = thread_create(f, NULL, 0, 30, -1, 1);
thread_set_weight(t11, 3);
thread_add_at(t11, 21);
struct thread *t12 = thread_create(f, NULL, 0, 33, -1, 1);
thread_set_weight(t12, 2);
thread_add_at(t12, 74);
struct thread *t13 = thread_create(f, NULL, 0, 34, -1, 1);
thread_set_weight(t13, 1);
thread_add_at(t13, 34);
struct thread *t14 = thread_create(f, NULL, 0, 52, -1, 1);
thread_set_weight(t14, 1);
thread_add_at(t14, 20);
struct thread *t15 = thread_create(f, NULL, 0, 42, -1, 1);
thread_set_weight(t15, 1);
thread_add_at(t15, 94);
thread_start_threading();
          printf("\nexited\n");
          exit(0);
          }