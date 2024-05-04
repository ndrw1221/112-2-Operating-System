#include "kernel/types.h"
#include "user/user.h"
#include "user/list.h"
#include "user/threads.h"
#include "user/threads_sched.h"

#define NULL 0
#define min(a, b) ((a) < (b) ? (a) : (b))

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    struct thread *thread_with_smallest_id = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list)
    {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
            thread_with_smallest_id = th;
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL)
    {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
        r.allocated_time = thread_with_smallest_id->remaining_time;
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    struct thread *current_thread = NULL;
    struct thread *th = NULL;
    // printf("\nrun_queue: \n");
    list_for_each_entry(th, args.run_queue, thread_list)
    {
        // printf("th->ID: %d; ", th->ID);
        // printf("th->arrival_time: %d\n", th->current_deadline - th->deadline);
        if (current_thread == NULL || (th->remaining_time == th->processing_time && th->ID < current_thread->ID))
            current_thread = th;
    }

    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    int weighted_time = args.time_quantum * current_thread->weight;
    int remaining_time = current_thread->remaining_time;
    if (current_thread != NULL)
    {
        r.scheduled_thread_list_member = &current_thread->thread_list;
        r.allocated_time = min(weighted_time, remaining_time);
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}

/* Shortest-Job-First Scheduling */
// struct threads_sched_result schedule_sjf(struct threads_sched_args args)
// {
//     struct threads_sched_result r;
//     // TODO: implement the shortest-job-first scheduling algorithm

//     return r;
// }

// /* MP3 Part 2 - Real-Time Scheduling*/
// /* Least-Slack-Time Scheduling */
// struct threads_sched_result schedule_lst(struct threads_sched_args args)
// {
//     struct threads_sched_result r;
//     // TODO: implement the least-slack-time scheduling algorithm

//     return r;
// }

// /* Deadline-Monotonic Scheduling */
// struct threads_sched_result schedule_dm(struct threads_sched_args args)
// {
//     struct threads_sched_result r;
//     // TODO: implement the deadline-monotonic scheduling algorithm

//     return r;
// }
