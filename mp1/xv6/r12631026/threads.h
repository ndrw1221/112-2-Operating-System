#ifndef THREADS_H_
#define THREADS_H_
#define NULL_FUNC ((void (*)(int))-1)
// TODO: necessary includes, if any
#include "user/setjmp.h"
// TODO: necessary defines, if any

struct thread {
    void (*fp)(void *arg); // function pointer
    void *arg; // function argument
    void *stack; 
    void *stack_p; 
    jmp_buf env; // for thread function
    int buf_set; // 1: indicate jmp_buf (env) has been set, 0: indicate jmp_buf (env) not set
    int ID;
    struct thread *previous;
    struct thread *next;
    struct task *top;
    struct task *current_task;
    int first_self_assign;
    int task_count;
};

struct task { // task stack implemented as linked list
    void (*fp)(void *arg);
    void *arg;
    void *stack; 
    void *stack_p; 
    jmp_buf env;
    int buf_set;
    int ID;
    struct task *next;
};

struct thread *thread_create(void (*f)(void *), void *arg);
void thread_add_runqueue(struct thread *t);
void thread_yield(void);
void dispatch(void);
void schedule(void);
void thread_exit(void);
void thread_start_threading(void);

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg);
void task_schedule(struct thread *t);
void thread_pop_task(void);
#endif // THREADS_H_
