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
        struct release_queue_entry *next_rqe = NULL;
        struct release_queue_entry *rqe = NULL;
        list_for_each_entry(rqe, args.release_queue, thread_list)
        {
            if (rqe == NULL || rqe->release_time < next_rqe->release_time)
                next_rqe = rqe;
        }

        r.scheduled_thread_list_member = args.run_queue;
        if (next_rqe != NULL)
            r.allocated_time = next_rqe->release_time - args.current_time;
        else
            r.allocated_time = 1;
    }

    return r;
}

/* Shortest-Job-First Scheduling */
struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    struct thread *shortest_job = NULL;
    struct thread *th = NULL;
    struct release_queue_entry *rqe = NULL;
    int smallest_release_time = 0;
    int allocated_time = 0;

    // printf("\n>> run_queue: \n");
    list_for_each_entry(th, args.run_queue, thread_list)
    {
        // printf("th->ID: %d; ", th->ID);
        // printf("th->arrival_time: %d; ", th->current_deadline - th->deadline);
        // printf("th->remaining_time: %d; ", th->remaining_time);
        // printf("th->finish time: %d\n", args.current_time + th->remaining_time);

        // Find the shortest job in the run queue
        if (shortest_job == NULL || th->remaining_time < shortest_job->remaining_time)
            shortest_job = th;
        else if (th->remaining_time == shortest_job->remaining_time && th->ID < shortest_job->ID)
            shortest_job = th;
    }
    allocated_time = shortest_job->remaining_time;

    // printf("\n>> release_queue: \n");
    list_for_each_entry(rqe, args.release_queue, thread_list)
    {
        // printf("rqe->thrd->ID: %d; ", rqe->thrd->ID);
        // printf("rqe->release_time: %d; ", rqe->release_time);
        // printf("rqe->thrd->processing_time: %d\n", rqe->thrd->processing_time);

        // If any job in the release queue has a shorter processing time than the shortest job
        // and the job is released before the shortest job finishes
        if (rqe->thrd->processing_time < shortest_job->remaining_time &&            // shorter job
            rqe->release_time < (args.current_time + shortest_job->remaining_time)) // released before the shortest job finishes
        {
            if (smallest_release_time == 0 || rqe->release_time < smallest_release_time)
            {
                smallest_release_time = rqe->release_time;
                allocated_time = smallest_release_time - args.current_time;
            }
        }
    }

    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    if (shortest_job != NULL)
    {
        r.scheduled_thread_list_member = &shortest_job->thread_list;
        r.allocated_time = allocated_time;
    }
    else
    {
        struct release_queue_entry *next_rqe = NULL;
        struct release_queue_entry *rqe = NULL;
        list_for_each_entry(rqe, args.release_queue, thread_list)
        {
            if (rqe == NULL || rqe->release_time < next_rqe->release_time)
                next_rqe = rqe;
        }

        r.scheduled_thread_list_member = args.run_queue;
        if (next_rqe != NULL)
            r.allocated_time = next_rqe->release_time - args.current_time;
        else
            r.allocated_time = 1;
    }

    return r;
}

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    struct thread *least_slack_time_thread = NULL;
    struct thread *th = NULL;
    struct release_queue_entry *rqe = NULL;
    int allocated_time = 0;
    int smallest_release_time = 0;
#define slack_time(th) (th->current_deadline - args.current_time - th->remaining_time)
#define slack_time_at(th, t) (th->current_deadline - t - th->remaining_time)

    // printf("\n>> run_queue: \n");
    list_for_each_entry(th, args.run_queue, thread_list)
    {
        // printf("th->ID: %d; ", th->ID);
        // printf("th->slack_time: %d\n", slack_time(th));

        if (least_slack_time_thread == NULL || slack_time(th) < slack_time(least_slack_time_thread))
            least_slack_time_thread = th;
        else if (slack_time(th) == slack_time(least_slack_time_thread) && th->ID < least_slack_time_thread->ID)
            least_slack_time_thread = th;
    }
    allocated_time = least_slack_time_thread->remaining_time;

    // printf("\n>> release_queue: \n");
    list_for_each_entry(rqe, args.release_queue, thread_list)
    {
        // printf("rqe->thrd->ID: %d; ", rqe->thrd->ID);
        // printf("rqe->release_time: %d; ", rqe->release_time);
        // printf("rqe->thrd->processing_time: %d\n", rqe->thrd->processing_time);
        if (rqe->release_time < args.current_time + least_slack_time_thread->remaining_time &&
            slack_time_at(rqe->thrd, rqe->release_time) < slack_time(least_slack_time_thread))
        {
            if (smallest_release_time == 0 || rqe->release_time < smallest_release_time)
            {
                smallest_release_time = rqe->release_time;
                allocated_time = smallest_release_time - args.current_time;
            }
        }
        else if (rqe->release_time < args.current_time + least_slack_time_thread->remaining_time &&
                 slack_time_at(rqe->thrd, rqe->release_time) == slack_time(least_slack_time_thread) &&
                 rqe->thrd->ID < least_slack_time_thread->ID)
        {
            if (smallest_release_time == 0 || rqe->release_time < smallest_release_time)
            {
                smallest_release_time = rqe->release_time;
                allocated_time = smallest_release_time - args.current_time;
            }
        }
    }

    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    if (least_slack_time_thread != NULL)
    {
        r.scheduled_thread_list_member = &least_slack_time_thread->thread_list;
        r.allocated_time = allocated_time;
    }
    else
    {
        struct release_queue_entry *next_rqe = NULL;
        struct release_queue_entry *rqe = NULL;
        list_for_each_entry(rqe, args.release_queue, thread_list)
        {
            if (rqe == NULL || rqe->release_time < next_rqe->release_time)
                next_rqe = rqe;
        }

        r.scheduled_thread_list_member = args.run_queue;
        if (next_rqe != NULL)
            r.allocated_time = next_rqe->release_time - args.current_time;
        else
            r.allocated_time = 1;
    }

    return r;
}

// /* Deadline-Monotonic Scheduling */
// struct threads_sched_result schedule_dm(struct threads_sched_args args)
// {
//     struct threads_sched_result r;
//     // TODO: implement the deadline-monotonic scheduling algorithm

//     return r;
// }
