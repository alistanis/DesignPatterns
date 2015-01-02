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
VALUE method_read_file(VALUE self);
VALUE method_write_new_file(VALUE self);

/*
    Checks if file exists
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
    Simple file_info struct for passing a file path and a read_size to a function
 */
typedef struct {
    char *file_name;
    int read_size;
} file_info;


/*
    Read file function that takes a file_info struct (declared above) as an argument instead of separate parameters.
 */
char *var_read_file(file_info in)
{
    char *file_name = in.file_name ? in.file_name : "";
    int i_out = in.read_size ? in.read_size : 0;
    return read_file_base(file_name, i_out);
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
    Variable argument definition for being able to call read_file with 1 parameter (filename) or 2 parameters (filename, read_size)
    Technically this could be called with 0 parameters, but we haven't defined it that way with rb_define_method, so it would raise an argument error.
    Also, even if we were able to call it with 0 parameters, it would exit(EXIT_FAILURE) because we obviously need a file name in order to read a file.
 */
#define read_file(...) var_read_file((file_info){__VA_ARGS__});

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
    The ruby shell method that gets called - The "VALUE filename" is coerced into a string value, and then we take its pointer and assign it to a char pointer.
    After that we create a buffer and pass the buffer into the read_file macro function - named parameters are used in this case for legibility but as explained in the variadic macro
    definition above, the read_file function can be called with named parameters, a single file name, or multiple parameters, and it will still function properly.
*/
VALUE rb_read_file(VALUE self, VALUE filename)
{
    VALUE r_string_value = StringValue(filename);
    char *file_path = RSTRING_PTR(r_string_value);
    const char *buffer = read_file(.file_name = file_path);
    VALUE r_string = rb_str_new2(buffer);
    free((void *)buffer);
    return r_string;
}

VALUE rb_read_file2(VALUE self, VALUE filename, VALUE read_size)
{
    VALUE r_string_value = StringValue(filename);
    char *file_path = RSTRING_PTR(r_string_value);
    int int_read_size = FIX2INT(read_size);
    const char *buffer = read_file(.file_name = file_path, .read_size = int_read_size);
    VALUE r_string = rb_str_new2(buffer);
    free((void *)buffer);
    return r_string;
}

VALUE rb_write_new_file(VALUE self, VALUE filename, VALUE data)
{
    VALUE r_string_filename = StringValue(filename);
    VALUE r_string_data = StringValue(data);

    char *file_path = RSTRING_PTR(r_string_filename);
    char *file_data = RSTRING_PTR(r_string_data);

    return INT2FIX(write_new_file(file_path, file_data));
}

// The initialization method for this module. Defines the module and its methods for us to use in Ruby.
void Init_CIO() {
    // Defines the CIO module in ruby
    CIO = rb_define_module("CIO");
    //Defines the read_file method in ruby
    // Params: module_name, method_name, actual method being called, number of arguments
    rb_define_method(CIO, "read_file", rb_read_file, 1);
    //Defines second read file method, this one taking a block read_size integer for the number of bytes to read at a time. Can make file reading much faster.
    rb_define_method(CIO, "read_file", rb_read_file2, 2);
    //Defines the write_new_file method in ruby
    rb_define_method(CIO, "write_new_file", rb_write_new_file, 2);
}