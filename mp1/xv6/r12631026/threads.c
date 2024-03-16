#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0

static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
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
    // printf("thread %d created\n", t->ID);
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
    // printf("thread %d added to runqueue\n", t->ID);
}
void thread_yield(void){
    // TODO
    // Suspends the current thread and save its context to the jmp_buf
    if(current_thread->buf_set == 0) {
        current_thread->buf_set = 1;
    }

    if(!setjmp(current_thread->env)){ // save the current thread's context
        schedule();
        dispatch();
    }
    // printf("thread %d yielded\n", current_thread->ID);
}
void dispatch(void){
    // TODO
    if(current_thread->buf_set != 0) {
        longjmp(current_thread->env, 1); // restore the context of the current thread
    } else { // never been yielded before
        if(!setjmp(current_thread->env)){
            current_thread->env->sp = ((unsigned long) current_thread->stack_p);
            longjmp(current_thread->env, 1);
        } else {
            current_thread->fp(current_thread->arg);
        }
        thread_exit();
    }
    // printf("thread %d dispatched\n", current_thread->ID);
}
void schedule(void){
    // TODO
    current_thread = current_thread->next;
}
void thread_exit(void){
    if(current_thread->next != current_thread){
        // TODO
        // Remove the current thread from the runqueue
        struct thread *temp = current_thread;
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;

        schedule();
        free(temp->stack);
        free(temp);
        
        dispatch();
    } else {
        // TODO
        // Hint: No more thread to execute
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st, 1);
    }
    // printf("thread %d exited\n", current_thread->ID);
}
void thread_start_threading(void){
    // TODO
    if (!setjmp(env_st)) {
        // printf("threading started\n");
        dispatch();
    }
}

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg){
    // TODO
}
