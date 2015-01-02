#include "cio.h"
/*
 *	How to call this from Ruby: verbatim code inside ``
 *		run Ruby extconf.rb # `./extconf.rb` or `ruby extconf.rb`
 *		run `make`
 *		run `make install`
 *	This will install the correct package for your operating system. Currently only tested on Mac OSX 10.10
 *
 *	From Ruby:
 *		require 'CIO'
 *		include CIO
 *			sherlock_holmes_a_study_in_scarlet = read_file("/Users/Chris/Documents/study_in_scarlet.txt")
 *          or
 *          puts CIO.read_file("/Users/Chris/Documents/study_in_scarlet.txt")
 *
 *          sherlock_book = read_file("/path_to_book/book.txt", 32000)
 *
 *          write_new_file("/path_to_file.txt", file_data)
 */

// Defines a space for information and references about the module to be stored internally
VALUE CIO = Qnil;

// Prototype for the initialization method - Required by Ruby
void Init_CIO();

// Defines our method Prototypes, all methods here must be prefaced with method_
// Prototype for read_file_base
VALUE method_read_file_base(VALUE self);
// Prototype for write_new_file
VALUE method_write_new_file(VALUE self);
// Prototype for copy_file_base
VALUE method_copy_file_base(VALUE self);
// Prototype for list_dirs
VALUE method_list_dirs(VALUE self);

/*
    Variable argument definition for being able to call read_file with 1 parameter (char *filename) or 2 parameters (char *filename, int read_size)
    Technically this could be called with 0 parameters, but we haven't defined it that way with rb_define_method, so it would raise an argument error.
    Also, even if we were able to call it with 0 parameters, it would exit(EXIT_FAILURE) because we obviously need a file name in order to read a file.
 */
#define read_file(...) var_read_file((file_info){__VA_ARGS__});
/*
    Variable argument definition for being able to call copy_file with 2 parameters (char *filename, char *destination) or 3 parameters (char *filename, char *destination, int read_size)
*/
#define copy_file(...) var_copy_file((copy_file_struct){__VA_ARGS__});

/*
    Checks if file exists. Returns 1 if it does and 0 if it does not.
 */
int does_file_exist(const char *filename)
{
    struct stat st;
    int result = stat(filename, &st);
    return result == 0;
}

/*
    Gets the file size
*/
size_t get_file_size(const char *filename)
{   off_t size;
    struct stat st;
    stat(filename, &st);
    size = st.st_size;
    return (size_t)size;
}

/*
    Read file function that takes a file_info struct (declared above) as an argument instead of separate parameters.
 */
char *var_read_file(file_info in)
{
    const char *file_name = in.file_name ? in.file_name : "";
    int i_out = in.read_size ? in.read_size : 0;
    return read_file_base(file_name, i_out);
}

/*
    Lists directories up to the level passed in
*/
void list_dirs(const char *name, int level)
{
    DIR *dir;
    struct dirent *entry;

    if (!(dir = opendir(name)))
        return;
    if (!(entry = readdir(dir)))
        return;

    do {
        if (entry->d_type == DT_DIR) {
            char path[1024];
            int len = snprintf(path, sizeof(path)-1, "%s/%s", name, entry->d_name);
            path[len] = 0;
            if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0)
                continue;
            printf("%*s[%s]\n", level*2, "", entry->d_name);
            list_dirs(path, level + 1);
        }
        else
            printf("%*s- %s\n", level*2, "", entry->d_name);
    } while ((entry = readdir(dir)));
    closedir(dir);
}

/*
    Base read file function. Takes a filename and a read_size (for number of bytes to read at a time)
 */
char *read_file_base(const char *filename, int read_size)
{
    if (strcmp(filename, "") == 0)
    {
        printf("You must provide a file name\n");
        exit(EXIT_FAILURE);
    }

    size_t file_size = get_file_size(filename);
    //printf("File size: %zu\n", file_size);
    /* Open file in read mode only */
    FILE *fp = fopen(filename, "r");
    int fd = fileno(fp);
    int flags = fcntl(fd, F_GETFL, 0);
    fcntl(fd, F_SETFL, flags | O_NONBLOCK);

    /* Make sure fileSize is > 0 */
    /* if the read size is 0 it is the default, set read size to the size of the file; this will be a blocking read, technically */
    if (read_size == 0)
    {
        read_size = (int)file_size;
    }

    if (file_size <= 0) {
        perror("Filesize is less than or equal to 0");
    }

    /*
        Seems like calloc is faster, at least on osx
     */
    char *buffer = calloc(file_size, sizeof(char));
    //char *buffer = malloc(file_size * sizeof(char));
    //memset(buffer, 0, file_size * sizeof(char));

    if (buffer == NULL) {
        /* Handle allocation error */
        perror("There was an allocation error: you out of memory, son?\n");
    }
    char *temp_buffer = calloc(read_size, sizeof(char));
    //char *temp_buffer = malloc(read_size * sizeof(char));
    //memset(temp_buffer, 0, read_size * sizeof(char));
    if (temp_buffer == NULL) {
        /* Handle allocation error */
        perror("There was an allocation error: you out of memory, son?\n");
    }

    size_t total_bytes_read = 0;
    while(total_bytes_read < file_size){
        ssize_t bytes_read = read(fd, temp_buffer, read_size);

        /* Only increment and add it to the buffer if read function is successful */
        if (bytes_read > 0)
        {
            total_bytes_read += bytes_read;
            /* Copy temp buffer to end of current buffer */
            strncat(buffer, temp_buffer, bytes_read);
        }
        /* If the total bytes read + the curent read size are greater than the size of the file */
        if (total_bytes_read + read_size > file_size)
        {
            /* Set read size to the remaining number of bytes in the file */
            read_size = (int)file_size - (int)total_bytes_read;
            /* Free the temporary buffer */
            free(temp_buffer);
            /* malloc the buffer to the remaining size */
            temp_buffer = malloc(read_size * sizeof(char));
        }
        //printf("Read size: %d\n", read_size);
        //printf("File size: %zu\n", file_size);
        //printf("Bytes read: %zu\n", bytes_read);
        //printf("Total bytes read: %zu\n\n", total_bytes_read);
    }
    /* Free the fencepost malloc */
    free(temp_buffer);

    /* Close file descriptor */
    close(fd);
    /* Close file pointer */
    fclose(fp);
    return buffer;
}

/*
 Writes content of char *data to new file named filename.
 Returns number of bytes written or -1 on error
 */
int write_new_file(const char *filename, char *data)
{
    FILE *fp;
    fp = fopen(filename, "w+");
    fprintf(fp, "%s", data);
    fclose(fp);

    return 0;
}

/*
    Base copy file function, reads a file at filename with a block read size and writes it out to destination.
*/
int copy_file_base(const char *filename, const char *destination, int read_size)
{
    char *data = read_file(filename, read_size);
    return write_new_file(destination, data);
}

/*
    Takes a filename and a file_info struct and calls copy_file_base.
*/
int var_copy_file(copy_file_struct in)
{
    const char *filename = in.file_name ? in.file_name : "";
    const char *destination = in.destination ? in.destination: "";
    int i_out = in.read_size ? in.read_size : 0;
    return copy_file_base(filename, destination, i_out);
}

/*
    Exposes the write_new_file function to ruby
*/
VALUE rb_write_new_file(VALUE self, VALUE filename, VALUE data)
{
    VALUE r_string_filename = StringValue(filename);
    VALUE r_string_data = StringValue(data);

    char *file_path = RSTRING_PTR(r_string_filename);
    char *file_data = RSTRING_PTR(r_string_data);

    return INT2FIX(write_new_file(file_path, file_data));
}

/*
    Exposes read_file_base to ruby
*/
VALUE rb_read_file_base(int argc, VALUE *argv, VALUE self)
{
    if (argc > 2 || argc < 1) {  // There should only be 1..2 arguments
                rb_raise(rb_eArgError, "wrong number of arguments");
            }
            VALUE r_string_filename = StringValue(argv[0]);
            char *file_path = RSTRING_PTR(r_string_filename);
            const char *buffer;
            VALUE r_read_size;
            if (argc == 2)
            {
                r_read_size = argv[1];
                int read_size = FIX2INT(r_read_size);
                buffer = read_file(.file_name = file_path, .read_size = read_size);
            }
            else
            {
                buffer = read_file(.file_name = file_path);
            }

        VALUE r_string = rb_str_new2(buffer);
        free((void *)buffer);
        return r_string;
}

/*
    Exposes copy_file_base to ruby
*/
VALUE rb_copy_file_base(int argc, VALUE *argv, VALUE self)
{
    if (argc > 3 || argc < 2) {  // There should only be 2..3 arguments
            rb_raise(rb_eArgError, "wrong number of arguments");
        }
        VALUE r_string_filename = StringValue(argv[0]);
        char *file_name = RSTRING_PTR(r_string_filename);
        VALUE r_string_destination = StringValue(argv[1]);
        char *destination = RSTRING_PTR(r_string_destination);
        VALUE r_read_size;
        if (argc == 3)
        {
            r_read_size = argv[2];
            copy_file(.file_name = file_name, .destination = destination, .read_size = FIX2INT(r_read_size));
        }
        else
        {
            copy_file(.file_name = file_name, .destination = destination);
        }
        return INT2FIX(does_file_exist(destination));
}


/*
    Exposes the list_dirs method to ruby
*/
VALUE rb_list_dirs(VALUE self, VALUE directory, VALUE level)
{
    VALUE r_string_directory = StringValue(directory);

    char *dir = RSTRING_PTR(r_string_directory);
    int lev = FIX2INT(level);
    list_dirs(dir, lev);
    return Qnil;
}

// The initialization method for this module. Defines the module and its methods for us to use in Ruby.
void Init_CIO() {
    // Defines the CIO module in ruby
    CIO = rb_define_module("CIO");
    // Params: module_name, method_name, actual method being called, number of arguments
    //Defines the read_file method in ruby
    rb_define_method(CIO, "read_file", rb_read_file_base, -1);
    //Defines the write_new_file method in ruby
    rb_define_method(CIO, "write_new_file", rb_write_new_file, 2);
    //Defines copy_file method in ruby
    rb_define_method(CIO, "copy_file", rb_copy_file_base, -1);
    //Defines list_dirs in ruby
    rb_define_method(CIO, "list_dirs", rb_list_dirs, 2);
}