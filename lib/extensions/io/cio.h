#include "ruby.h"
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>

int does_file_exist(const char *filename);
size_t get_file_size(const char *filename);

char *read_file_base(const char *filename, int size);

int write_new_file(const char *filename, char *data);