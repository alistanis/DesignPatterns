#include "ruby.h"
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>

// Foward Declarations

/*
    Simple file_info struct for passing a file path and a read_size to a function
 */
typedef struct {
    const char *file_name;
    int read_size;
} file_info;

/*
    Another simple struct for passing multiple arguments to the copy_file functions
*/
typedef struct {
    const char *file_name;
    const char *destination;
    int read_size;
} copy_file_struct;

/*
    Checks to see if the file specified by filename exists.
*/
int does_file_exist(const char *filename);
/*
    Returns a file size in bytes, 0 if it doesn't exist
*/
size_t get_file_size(const char *filename);
/*
    Reads a file at filename with a read_size specified by size
*/
char *read_file_base(const char *filename, int size);
/*
    Writes data out to a new file. Will replace the file data if it exists.
*/
int write_new_file(const char *filename, char *data);
/*
    Reads a file - calls read_file_base with parameters from file_info struct
*/
char *var_read_file(file_info in);
/*
    Copies a file at filename to destination with a read size specified by read_size
*/
int copy_file_base(const char *filename, const char *destination, int read_size);
/*
    Copies a file at filename out to a destination(with a read size) contained in file_info struct
*/
int var_copy_file(copy_file_struct in);
/*
    Prints out directory listings recursively up to the level specified by level
*/
void list_dirs(const char *name, int level);



