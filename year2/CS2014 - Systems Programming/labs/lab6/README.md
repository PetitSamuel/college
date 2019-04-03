# Lab 6 & 7: Huffman coding

## Submission
You only need to submit bitfile.c, huff.c, bitfile.h and huff.h on Submitty.  The test 
cases prefixed with "Default" on Submitty are provided to you.

## Note
If you are on a Unix system you can view the binary coding of your files with "xxd -b <file>"

## Small encoding example
When you are trying to debug your code for the encoding part it is easier to first make sure
it works on a small sequence.  
Here is an example of what encoding format is expected (tiny-encoding).
The encoding generated using the modern-prometheus-unix.txt file should the following codes:
d: 11000
newline: 101101
EOT: 1000101100011110110
The encoding of a file containing only "d" and a newline would be :
11000101 10110001 01100011 11011000
The first bit of this sequence goes into bit 0 of the first byte.

If you use "xxd -b <file>" to display the binary coding of your encoded file, you should see:
10100011 10001101 11000110 00011011 
