// code for a huffman coder


#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <ctype.h>

#include "huff.h"
#include "bitfile.h"


// sorting algorithm, sorts based on huffchar freq & seq number
void funnySort(struct huffchar * a[], int size) {
  int j;
  struct huffchar *temp;

  j = 0;
  while ( j < size - 1 ) {
    if (a[j]->freq < a[j+1]->freq || (a[j]->freq == a[j+1]->freq && a[j]->seqno < a[j+1]->seqno)) {
      temp = a[j];
      a[j] = a[j+1];
      a[j+1] = temp;
      j = 0;
    }
    else {
      j++;
    }
  }
}



// create a new huffchar structure
struct huffchar *  huffchar_new(int freq, unsigned char val, int seq)
{
  struct huffchar *s = malloc(sizeof(struct huffchar));
  s->freq = freq;
  s->seqno = seq;
  s->is_compound = 0;
  s->u.c = val;
  return s;
}

// create a new huffchar structure (compound)
struct huffchar *  huffchar_new_compound(int freq, struct huffchar * rightDude, struct huffchar * leftDude, int seq)
{
  struct huffchar *s = malloc(sizeof(struct huffchar) * 3);
  s->freq = freq;
  s->seqno = seq;
  s->is_compound = 1;
  s->u.compound.left = leftDude;
  s->u.compound.right = rightDude;

   
  return s;
}
// create a new huffcoder structure
struct huffcoder *  huffcoder_new()
{
  struct huffcoder *s = malloc(sizeof(struct huffcoder));
  s->tree = malloc(sizeof(struct huffchar));
  return s;
}

// count the frequency of characters in a file; set chars with zero
// frequency to one
void huffcoder_count(struct huffcoder * this, char * filename)
{
  // open file
  FILE *file;
  file=fopen(filename, "r");
  if(file == NULL){
    printf("Error when trying to open file\n");
    return;
  }
  int current;

  // compute frequencies
  while ((current = fgetc(file)) != EOF) this->freqs[current]++;

  // set freq 0 to 1
  for (int i = 0; i < NUM_CHARS; i++) {
    if (this->freqs[i] == 0) this->freqs[i] = 1;
  }
}


// using the character frequencies build the tree of compound
// and simple characters that are used to compute the Huffman codes
void huffcoder_build_tree(struct huffcoder * this)
{
  // make array of huffchars
  struct huffchar *vals[NUM_CHARS];
  int size = NUM_CHARS;
  int seq = 0;
  for (int i = 0; i < NUM_CHARS; i++) {
    struct huffchar *new = huffchar_new(this->freqs[i], (char)i, seq++);
    vals[i] = new;
  }
  struct huffchar *a,*b;

  // compute tree
  while (size > 1) {
    funnySort(vals, size);
    a = vals[size - 1];
    b = vals[size - 2];
    struct huffchar *new = huffchar_new_compound(a->freq + b->freq, b, a, seq++);
    vals[size - 2] = new;
    size--;
  }
  this->tree = vals[0];
} 


// recursive function to convert the Huffman tree into a table of
// Huffman codes
void tree2table_recursive(struct huffcoder * this, struct huffchar * node, unsigned long long * path, int depth)
{
  if (node->is_compound == 0) {
    // node is a char, add to codes
    int c = (int) node->u.c;
    this->code_lengths[c] = depth;
    this->codes[c] = *path;
  } else {
    // node is a compound, make next recursive call
    *path *= 2;
    unsigned long long val = *path;
    tree2table_recursive(this, node->u.compound.left, path, depth + 1);
    *path = val + 1;
    tree2table_recursive(this, node->u.compound.right, path, depth + 1);
  }
}

// using the Huffman tree, build a table of the Huffman codes
// with the huffcoder object
void huffcoder_tree2table(struct huffcoder * this)
{
  tree2table_recursive(this, this->tree, malloc(sizeof(unsigned long long)), 0);
}


// print the Huffman codes for each character in order;
// you should not modify this function
void huffcoder_print_codes(struct huffcoder * this)
{
  int i, j;
  char buffer[NUM_CHARS];

  for ( i = 0; i < NUM_CHARS; i++ ) {
    // put the code into a string
    assert(this->code_lengths[i] < NUM_CHARS);
    for ( j = this->code_lengths[i]-1; j >= 0; j--) {

      // the commented line was wrong, I changed it to this line of code instead : 
      buffer[j] = ((this->codes[i] >> ((this->code_lengths[i] - 1) - j) & 1) + '0'); 
      //buffer[j] = ((this->codes[i] >> j) & 1) + '0';
    }
    // don't forget to add a zero to end of string
    buffer[this->code_lengths[i]] = '\0';

    // print the code
    printf("char: %d, freq: %d, code: %s\n", i, this->freqs[i], buffer);;
  }
}

// encode the input file and write the encoding to the output file
void huffcoder_encode(struct huffcoder * this, char * input_filename, char * output_filename) {
  // open input file
  FILE *in;
  in=fopen(input_filename, "r");
  if(in == NULL){
    printf("Error when trying to open file\n");
    return;
  }

  // open output file
  char * c = malloc(sizeof(char));
  *c = 'w';
  struct bitfile * out = bitfile_open(output_filename, c);
  // read line by line

  int current;
  int loop = 1;
  while (loop == 1)
  {
    current = fgetc(in);
    if (current == EOF) {
      // if EOF add EOT
      current = 4;
      loop = 0;
    }
    for (int j = 0; j < this->code_lengths[current]; j++) {
        bitfile_write_bit(out,  ((this->codes[current] >> ((this->code_lengths[current] - 1) - j) & 1)));
    }
  }

  fclose(in);
  bitfile_close(out);
}

// decode the input file and write the decoding to the output file
void huffcoder_decode(struct huffcoder * this, char * input_filename, char * output_filename) {
  // open input file
  FILE *out;
  out=fopen(output_filename, "w");
  if(out == NULL){
    printf("Error when trying to open file\n");
    return;
  }

  // open output file
  char * c = malloc(sizeof(char));
  *c = 'r';
  struct bitfile * in = bitfile_open(input_filename, c);
  struct huffchar * node = this->tree;
  while (!bitfile_end_of_file(in))
  {
    int bit = bitfile_read_bit(in);
    //printf("current bit %d\n", bit);
    if (bit == -1) {
      break;
    }
    if (node->is_compound == 0) {
      if (node->u.c == 4) {
        in->is_EOF = 1;
      }
      if (!bitfile_end_of_file(in)) {
        fprintf(out, "%c", node->u.c);
        node = this->tree; 
      }
    }
    if (bit == 1) {
      node = node->u.compound.right;
    } else {
      node = node->u.compound.left;
    }
  }

  fclose(out);
  bitfile_close(in);
}