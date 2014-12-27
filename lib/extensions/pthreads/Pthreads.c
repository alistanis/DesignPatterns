#include "Pthreads.h"

// Defining a space for information and references about the module to be stored internally
VALUE PThreads = Qnil;

// Prototype for the initialization method - Ruby calls this, not you
void Init_PThreads();

// Prototype for our method 'test1' - methods are prefixed by 'method_' here
VALUE method_pthread_test(VALUE self);
VALUE method_print_hello(VALUE self);

int get_cpu_count()
{
    return sysconf(_SC_NPROCESSORS_ONLN);
}

void *run_block(void *arguments)
{
    long tid;
    struct arg_struct *args = (struct arg_struct *)arguments;
    tid = (long)args->threadid;
    printf("Hello World! It's me, thread #%ld!\n", tid);

    pthread_exit(NULL);
}

VALUE pthread_test(VALUE self) {
    time_t rawtime;
    struct tm * timeinfo;
    int num_threads = get_cpu_count();
    time ( &rawtime );
    timeinfo = localtime ( &rawtime );
    printf ( "Current local time and date: %s", asctime (timeinfo) );

    clock_t begin, end;
    double time_spent;

    begin = clock();

    pthread_t threads[num_threads];
    int rc;
    long t;


    VALUE p;

    if(rb_block_given_p())
    {
        p = rb_block_proc();
        printf("Block was provided.\n");
    }
    else
    {
        rb_raise(rb_eArgError, "a block is required");
        return Qnil;
    }

    rb_funcall(p, rb_intern("call"), 0);

    for(t=0; t<num_threads; t++){
        printf("In main: creating thread %ld\n", t);

        struct arg_struct thread_args;
        thread_args.threadid = t;


        rc = pthread_create(&threads[t], NULL, run_block, (void *)&thread_args);
        if (rc){
            printf("ERROR; return code from pthread_create() is %d\n", rc);
            exit(-1);
        }
    }

    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;

    VALUE run_time = rb_float_new(time_spent);
    return run_time;
}

// The initialization method for this module
void Init_PThreads() {
    PThreads = rb_define_module("PThreads");
    rb_define_method(PThreads, "pthreads", pthread_test, 0);
}