#include "kernel/types.h"
          #include "user/user.h"
          #include "user/threads.h"
          #define NULL 0
          int k = 0;
          void f(void *arg){
              while (1) k++;
          }
          int main(int argc, char **argv){
          struct thread *t1 = thread_create(f, NULL, 0, 49, -1, 1);
thread_set_weight(t1, 3);
thread_add_at(t1, 95);
struct thread *t2 = thread_create(f, NULL, 0, 62, -1, 1);
thread_set_weight(t2, 2);
thread_add_at(t2, 73);
struct thread *t3 = thread_create(f, NULL, 0, 36, -1, 1);
thread_set_weight(t3, 4);
thread_add_at(t3, 88);
struct thread *t4 = thread_create(f, NULL, 0, 57, -1, 1);
thread_set_weight(t4, 4);
thread_add_at(t4, 97);
struct thread *t5 = thread_create(f, NULL, 0, 55, -1, 1);
thread_set_weight(t5, 4);
thread_add_at(t5, 15);
struct thread *t6 = thread_create(f, NULL, 0, 8, -1, 1);
thread_set_weight(t6, 3);
thread_add_at(t6, 39);
struct thread *t7 = thread_create(f, NULL, 0, 59, -1, 1);
thread_set_weight(t7, 2);
thread_add_at(t7, 17);
struct thread *t8 = thread_create(f, NULL, 0, 31, -1, 1);
thread_set_weight(t8, 1);
thread_add_at(t8, 57);
struct thread *t9 = thread_create(f, NULL, 0, 57, -1, 1);
thread_set_weight(t9, 1);
thread_add_at(t9, 78);
struct thread *t10 = thread_create(f, NULL, 0, 14, -1, 1);
thread_set_weight(t10, 1);
thread_add_at(t10, 1);
struct thread *t11 = thread_create(f, NULL, 0, 46, -1, 1);
thread_set_weight(t11, 3);
thread_add_at(t11, 88);
struct thread *t12 = thread_create(f, NULL, 0, 61, -1, 1);
thread_set_weight(t12, 1);
thread_add_at(t12, 17);
struct thread *t13 = thread_create(f, NULL, 0, 55, -1, 1);
thread_set_weight(t13, 3);
thread_add_at(t13, 71);
struct thread *t14 = thread_create(f, NULL, 0, 23, -1, 1);
thread_set_weight(t14, 3);
thread_add_at(t14, 82);
struct thread *t15 = thread_create(f, NULL, 0, 47, -1, 1);
thread_set_weight(t15, 3);
thread_add_at(t15, 1);
thread_start_threading();
          printf("\nexited\n");
          exit(0);
          }