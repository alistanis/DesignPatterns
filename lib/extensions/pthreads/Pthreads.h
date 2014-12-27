// Include the Ruby headers and goodies
#include "ruby.h"
#include <pthread.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

struct arg_struct {
	long threadid;
	VALUE block;
};