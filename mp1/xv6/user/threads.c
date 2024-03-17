#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0

static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
static int verbose = 0;
// static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
    t->arg = arg;
    t->ID  = id;
    t->buf_set = 0;
    t->stack = (void*) new_stack;
    t->stack_p = (void*) new_stack_p;
    id++;
    return t;
}
void thread_add_runqueue(struct thread *t){
    if(current_thread == NULL){
        // TODO
        t->next = t;
        t->previous = t;
        current_thread = t;
    }
    else{
        // TODO
        // Insert the new thread at the end of the runqueue,
        // i.e. the newly inserted thread should be current_thread->previous.
        (current_thread->previous)->next = t;
        t->previous = current_thread->previous;

        t->next = current_thread;
        current_thread->previous = t;
    }
    if(verbose) printf("thread %d added to runqueue\n", t->ID);
}
void thread_yield(void){
    // TODO
    if(verbose) printf("thread %d yielded\n", current_thread->ID);

    int *buf_set;
    jmp_buf *env;

    if (current_thread->top != NULL) { // called by task
        if(verbose) printf("task %d yielded\n", current_thread->ID);
        buf_set = &(current_thread->top->buf_set);
        env = &(current_thread->top->env);
        thread_pop_task();
    } else { // called by thread
        if(verbose) printf("thread %d yielded\n", current_thread->ID);
        buf_set = &(current_thread->buf_set);
        env = &(current_thread->env);
    }

    if(*buf_set == 0) {
        *buf_set = 1;
    }

    if(!setjmp(*env)){ // save the current context
        schedule();
        dispatch();
    }
}

void dispatch(void){ 
    // TODO
    if(current_thread->top != NULL) {
        // if(current_thread->top->buf_set != 0) {
        //     longjmp(current_thread->top->env, 1); // restore the context of the current thread
        // } else {
        //     if(!setjmp(current_thread->top->env)){
        //         current_thread->top->env->sp = ((unsigned long) current_thread->stack_p);
        //         longjmp(current_thread->top->env, 1);
        //     } else {
        //         current_thread->top->fp(current_thread->top->arg);
        //     }
        //     thread_pop_task();
        // } 
        current_thread->top->fp(current_thread->top->arg);
        if(verbose) printf("task dispatched\n");
        thread_pop_task();
        dispatch();
    } else {
        if(current_thread->buf_set != 0) {
            longjmp(current_thread->env, 1); // restore the context of the current thread
        } else {
            if(!setjmp(current_thread->env)){
                current_thread->env->sp = ((unsigned long) current_thread->stack_p);
                longjmp(current_thread->env, 1);
            } else {
                current_thread->fp(current_thread->arg);
                if(verbose) printf("thread %d dispatched\n", current_thread->ID);
            }
            thread_exit();
        }
    }
}

void schedule(void){
    // TODO
    current_thread = current_thread->next;
}
void thread_exit(void){
    if(current_thread->next != current_thread){
        // TODO
        // Remove the current thread from the runqueue and free the memory
        struct thread *temp = current_thread;
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;

        schedule();
        free(temp->stack);
        free(temp);
        if(verbose) printf("thread %d exited\n", current_thread->ID);
        
        dispatch();
    } else {
        // TODO
        // Hint: No more thread to execute
        free(current_thread->stack);
        free(current_thread);
        if(verbose) {
            printf("thread %d exited\n", current_thread->ID);
            printf("all threads exited\n");
        }
        longjmp(env_st, 1);
    }
}
void thread_start_threading(void){
    // TODO
    if (!setjmp(env_st)) {
        if(verbose) printf("threading start\n");
        dispatch();
    }
}

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg){
    // TODO
    struct task *new_task = (struct task*) malloc(sizeof(struct task));
    new_task->fp = f;
    new_task->arg = arg;
    new_task->next = t->top;
    t->top = new_task;
    if(verbose) printf("task assigned to thread %d\n", t->ID);
}

void thread_pop_task(void){
    struct task *temp = current_thread->top;
    current_thread->top = current_thread->top->next;
    free(temp);
    if(verbose) printf("task popped from thread %d\n", current_thread->ID);
}