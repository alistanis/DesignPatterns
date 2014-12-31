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

int doesFileExist(const char *filename);
size_t getFileSize(const char *filename);

char *readFileNonBlock(const char *filename);

char *read_file_base(const char *filename, int size);


int writeToNewFile(const char *filename, char *data);