// code for a huffman coder


#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <ctype.h>

#include "huff.h"

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

// create a new huffchar structure
struct huffchar *  huffchar_new_compound(int freq, struct huffchar * l, struct huffchar * r, int seq)
{
  struct huffchar *s = malloc(sizeof(struct huffchar) * 3);
  s->freq = freq;
  s->seqno = seq;
  s->is_compound = 1;
  s->u.compound.left = l;
  s->u.compound.right = r;

    // lower freq -> left (or lower seq no)
  if (l->freq > r->freq) {
    s->u.compound.left = r;
    s->u.compound.right = l;
  } else if (l->freq < r->freq) {
    s->u.compound.left = l;
    s->u.compound.right = r;
  } else if (l->seqno > r->seqno) {
    s->u.compound.left = r;
    s->u.compound.right = l;
  } else {
    s->u.compound.left = l;
    s->u.compound.right = r;
  }
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
  FILE *file;
  file=fopen(filename, "r");
  if(file == NULL){
    printf("Error when trying to open file\n");
    return;
  }
  char *line = NULL;
  size_t len = 0  ;
  char read;
  while ((read = getline(&line, &len, file)) != -1) {
    int i = 0;
    while (line[i] != '\0') {
      this->freqs[(int)line[i]]++;
      i++;
    }
  }
  for (int i = 0; i < NUM_CHARS; i++) {
    if (this->freqs[i] == 0) this->freqs[i] = 1;
  }
}


// using the character frequencies build the tree of compound
// and simple characters that are used to compute the Huffman codes
void huffcoder_build_tree(struct huffcoder * this)
{
  struct huffchar *vals[NUM_CHARS];
  int size = NUM_CHARS;
  int seq = 0;
  for (int i = 0; i < NUM_CHARS; i++) {
    struct huffchar *new = huffchar_new(this->freqs[i], (char)i, seq++);
    vals[i] = new;
  }
  struct huffchar *a,*b;

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
  //printf("depth : %d, freq %d path : %lld  seq : %d\n", depth, node->freq, val, node->seqno);

  if (node->is_compound == 0) {
    int c = (int) node->u.c;
    this->code_lengths[c] = depth;
    this->codes[c] = *path;
  } else {
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