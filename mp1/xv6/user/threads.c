#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0

static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
// static jmp_buf env_tmp;
static int verbose = 0;

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
    
    t->top = NULL;
    t->current_task = NULL;
    t->task_count = 0;
    t->first_self_assign = 0;
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
    if(verbose) printf("[INFO] thread %d added to runqueue\n", t->ID);
}
void thread_yield(void){
    // TODO

    int *buf_set;
    jmp_buf *env;

    if (current_thread->current_task != NULL \
    && current_thread->first_self_assign == 0) { // called by task 
        if(verbose) printf("[INFO] task %d yielded\n",  current_thread->current_task->ID);
        buf_set = &(current_thread->current_task->buf_set);
        env = &(current_thread->current_task->env);
        // thread_pop_task();
    } else { // called by thread
        if(verbose) printf("[INFO] thread %d yielded\n", current_thread->ID);
        buf_set = &(current_thread->buf_set);
        env = &(current_thread->env);
    }

    if(*buf_set == 0) {
        *buf_set = 1;
    }

    if(!setjmp(*env)){ // save the current context
        task_schedule(current_thread);
        task_schedule(current_thread->next);
        schedule();
        dispatch();
    }
}

void dispatch(void){ 
    // TODO
    if(current_thread->current_task != NULL ) {
        if(current_thread->first_self_assign) current_thread->first_self_assign = 0;
        if(current_thread->current_task->buf_set != 0) {
            if(verbose) printf("[INFO] task %d restored\n", current_thread->current_task->ID);
            longjmp(current_thread->current_task->env, 1); // restore the context of the current thread
        } else {
            if(!setjmp(current_thread->current_task->env)){
                if(verbose) printf("[INFO] task %d initialized\n", current_thread->current_task->ID);
                // current_thread->current_task->buf_set = 1;
                current_thread->current_task->env->sp = ((unsigned long) current_thread->current_task->stack_p);
                longjmp(current_thread->current_task->env, 1);
            } else {
                if(verbose) printf("[INFO] task %d dispatched\n", current_thread->current_task->ID);
                current_thread->current_task->fp(current_thread->current_task->arg);
            }
            thread_pop_task();
            // dispatch();
        }
    } else {
        if(current_thread->buf_set != 0) {
            if(verbose) printf("[INFO] thread %d restored\n", current_thread->ID);
            longjmp(current_thread->env, 1); // restore the context of the current thread
        } else {
            if(!setjmp(current_thread->env)){
                if(verbose) printf("[INFO] thread %d initialized\n", current_thread->ID);
                current_thread->env->sp = ((unsigned long) current_thread->stack_p);
                longjmp(current_thread->env, 1);
            } else {
                if(verbose) printf("[INFO] thread %d dispatched\n", current_thread->ID);
                current_thread->fp(current_thread->arg);
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
        if(verbose) printf("[INFO] thread %d exited\n", current_thread->ID);
        struct thread *temp = current_thread;
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;

        task_schedule(temp->next);            
        schedule();
        free(temp->stack);
        free(temp);
        
        dispatch();
    } else {
        // TODO
        // Hint: No more thread to execute
        if(verbose) {
            printf("[INFO] thread %d exited\n", current_thread->ID);
            printf("[INFO] all threads exited\n");
        }
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st, 1);
    }
}
void thread_start_threading(void){
    // TODO
    if (!setjmp(env_st)) {
        if(verbose) printf("[INFO] threading start\n");
        dispatch();
    }
}

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg){
    // TODO
    struct task *new_task = (struct task*) malloc(sizeof(struct task));
    unsigned long new_stack;
    unsigned long new_stack_p;
    new_stack = (unsigned long) malloc(sizeof(unsigned long) * 0x100);
    new_stack_p = new_stack + (0x100 * 8 - 0x2 * 8);

    new_task->fp = f;
    new_task->arg = arg;
    new_task->buf_set = 0;
    t->task_count++;
    new_task->ID = t->task_count;
    new_task->stack = (void*) new_stack;
    new_task->stack_p = (void*) new_stack_p;

    new_task->next = t->top;
    t->top = new_task;

    if(t->current_task == NULL) {
        t->current_task = new_task;
    }

    if(t == current_thread && t->task_count == 1) {
        t->first_self_assign = 1;
    }

    if(verbose) printf("[INFO] task %d assigned to thread %d\n", new_task->ID, t->ID);
    if(verbose == 2) printf("[INFO] THREAD: %d, CURRENT: %d, TOP: %d\n\n", t->ID, t->current_task->ID, t->top->ID);


}

void task_schedule(struct thread *t) {
    if(verbose == 2) printf("\n[INFO] THREAD: %d, CURRENT: %d, TOP: %d\n", current_thread->ID, current_thread->current_task->ID, current_thread->top->ID);
    t->current_task = t->top;
    if(verbose == 2) printf("[INFO] current task matched top task\n");
    if(verbose == 2) printf("[INFO] THREAD: %d, CURRENT: %d, TOP: %d\n\n", current_thread->ID, current_thread->current_task->ID, current_thread->top->ID);
}

void thread_pop_task(void){
    if(verbose) printf("[INFO] task %d popped from thread %d\n", current_thread->current_task->ID, current_thread->ID);
    struct task *temp = current_thread->current_task;
    current_thread->top = current_thread->top->next;
    task_schedule(current_thread);
    free(temp->stack);
    free(temp);
    dispatch();
}