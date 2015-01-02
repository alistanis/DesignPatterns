// Include the Ruby headers and goodies
#include "ruby.h"
#include <pthread.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

// Defines a struct that holds a threadid and a ruby VALUE (should be a block of code) that can be passed to a void *
struct arg_struct {
	long threadid;
	VALUE block;
};