// C code file for  a file ADT where we can read a single bit at a
// time, or write a single bit at a time

#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <stdio.h>

#include "bitfile.h"

// open a bit file in "r" (read) mode or "w" (write) mode
struct bitfile * bitfile_open(char * filename, char * mode)
{
    struct bitfile *b = malloc(sizeof(struct bitfile));
    b->is_read_mode = (*mode == 'r') ? 1 : 0;
    b->buffer = 0;

    if (b->is_read_mode == 1) {
        b->file = fopen(filename, "r");
        b->index = 8;
    } else {
        b->file = fopen(filename, "w");
        b->index = 0;
    }
    b->is_EOF = 0;
    return b;
}

// write a bit to a file; the file must have been opened in write mode
void bitfile_write_bit(struct bitfile * this, int bit)
{
    //printf("size of index currently at %d, bit to add : %d\n", this->index, bit);
    if (this->index == 8) {
        fprintf(this->file, "%c", this->buffer);
        this->buffer = 0;
        this->index = 0;
    }
    this->buffer = this->buffer | (bit << this->index);
    this->index += 1;
}


// read a bit from a file; the file must have been opened in read mode
int bitfile_read_bit(struct bitfile * this)
{
    if (bitfile_end_of_file(this)) {
        return -1;
    }
    if (this->index == 8) {
        this->buffer = fgetc(this->file);
        this->index = 0;
    }
   int bit = (this->buffer >> (this->index) & 1);
   this->index += 1;
   return bit;
}


// close a bitfile; flush any partially-filled buffer if file is open
// in write mode
void bitfile_close(struct bitfile * this) {
    if (this->is_read_mode == 0 && this->buffer != 0) {
        fprintf(this->file, "%c", this->buffer);
    }
    fclose(this->file);
}

// check for end of file
int bitfile_end_of_file(struct bitfile * this)
{
    return this->is_EOF || feof(this->file);
}
