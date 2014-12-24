// Include the Ruby headers and goodies
#include "ruby.h"
#include <pthread.h>
#include <stdio.h>
#define NUM_THREADS     5

// Defining a space for information and references about the module to be stored internally
VALUE PThreads = Qnil;

// Prototype for the initialization method - Ruby calls this, not you
void Init_pthreads();

// Prototype for our method 'test1' - methods are prefixed by 'method_' here
VALUE method_pthread_test(VALUE self);


// Our 'test1' method.. it simply returns a value of '10' for now.
VALUE pthread_test(VALUE self, int num_threads, ) {
	int x = 10;
	return INT2NUM(x);
}



// The initialization method for this module
void Init_pthreads() {
	PThreads = rb_define_module("PThreads");
	rb_define_method(PThreads, "pthreads", pthread_test, 0);
}

