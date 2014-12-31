#include "cio.h"

VALUE CIO = Qnil;

// Prototype for the initialization method - Required by Ruby
void Init_CIO();

// Defines our method Prototype, all methods here must be prefaced with method_
VALUE method_read_file(VALUE self);
VALUE method_write_file(VALUE self);

/*
 Checks if file exists
 */
int doesFileExist(const char *filename)
{
    struct stat st;
    int result = stat(filename, &st);
    return result == 0;
}

size_t getFileSize(const char *filename)
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

    size_t file_size = getFileSize(filename);
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
 */
#define read_file(...) var_read_file((file_info){__VA_ARGS__});

/*
 Writes content of char *data to new file named filename.
 Returns number of bytes written or -1 on error
 */
int writeToNewFile(const char *filename, char *data)
{
    FILE *fp;
    fp = fopen(filename, "w+");
    fprintf(fp, "%s", data);
    fclose(fp);

    return 0;
}

VALUE rb_read_file(VALUE self, VALUE filename)
{
    VALUE r_string_value = StringValue(filename);
    char *file_path = RSTRING_PTR(filename);
    const char *buffer = read_file(.file_name = file_path);
    VALUE r_string = rb_str_new2(buffer);
    free((void *)buffer);
    return r_string;
}

// The initialization method for this module. Defines the module and its methods for us to use in Ruby.
void Init_CIO() {
    // Defines the PThreads module in ruby
    CIO = rb_define_module("CIO");
    //Defines the pthreads method in ruby
    rb_define_method(CIO, "read_file", rb_read_file, 1);
}