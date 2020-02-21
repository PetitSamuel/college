#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
#include <string.h>

#include "bitset.h"

// create a new, empty bit vector set with a universe of 'size' items
struct bitset * bitset_new(int size) {
  struct bitset *b = malloc(sizeof(struct bitset));
  b->vector = malloc(size / 8);

  int arraySize = sizeof(b->vector);
  for(int i = 0; i < arraySize; i++){
    b->vector[i] = 0;
  }
  return b;
};


// get the size of the universe of items that could be stored in the set
int bitset_size(struct bitset * this) {
  return sizeof(this->vector) * 32;
}

// get the amount of bits in an int
int count_set_bits_in_int(int number) {
  int i = 0;
  while (number)
  {
    i += number & 1;
    number >>= 1;
  }
  return i;
}

// get the number of items that are stored in the set
int bitset_cardinality(struct bitset * this) {
  int arraySize = sizeof(this->vector);
  int count = 0;
  for (int i = 0; i < arraySize; i++){
    count += count_set_bits_in_int(this->vector[i]);
  }
  return count;
}

// check to see if an item is in the set
int bitset_lookup(struct bitset * this, int item) {
  int a = 1 << item;
  //   int pos = floor(item / 32); was not supported by grader
  int pos = item / 32;
  if (pos >= sizeof(this->vector)) return -1;
  return (a & this->vector[pos]) == 0 ? 0 : 1;
}

// add an item, with number 'item' to the set
// has no effect if the item is already in the set
void bitset_add(struct bitset * this, int item) {
  //   int pos = item / 32; not supported by grader  
  int pos = item / 32;
  int index = item - (pos * 32);
  int val = 1 << index;
  this->vector[pos] = this->vector[pos] | val;
}

// remove an item with number 'item' from the set
void bitset_remove(struct bitset * this, int item) {
  // int pos = item / 32; not supported by grader
  int pos = item / 32;
  int index = item - (pos * 32);
  int val = 1 << index;

  // set to one regardless and invert it
  this->vector[pos] = this->vector[pos] | val;
  this->vector[pos] = this->vector[pos] ^ val;
}

// place the union of src1 and src2 into dest
void bitset_union(struct bitset * dest, struct bitset * src1, struct bitset * src2) {
  int arraySize = sizeof(dest->vector);
  for (int i = 0; i < arraySize; i++){
    dest->vector[i] = src1->vector[i] | src2->vector[i];
  }
}

// place the intersection of src1 and src2 into dest
void bitset_intersect(struct bitset * dest, struct bitset * src1, struct bitset * src2) {
  int arraySize = sizeof(dest->vector);
  for (int i = 0; i < arraySize; i++){
    dest->vector[i] = src1->vector[i] & src2->vector[i];
  }
}

// print the contents of the bitset
void bitset_print(struct bitset * this)
{
  int i;
  int size = bitset_size(this);
  for ( i = 0; i < size; i++ ) {
    if ( bitset_lookup(this, i) == 1 ) {
      printf("%d ", i);
    }
  }
  printf("\n");
}