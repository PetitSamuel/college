// do NOT modify this file
#ifndef __HEADER_GLOBAL__
#define __HEADER_GLOBAL__
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct Html_Doc_t{
    char *begin_text;
    char *end_text;
    char *body;
};
typedef struct Html_Doc_t Html_Doc;

char* strappend(char* dest, const char* source);

Html_Doc* new_html_doc();
void del_html_doc(Html_Doc* htmldoc);
void add_element(Html_Doc *htmldoc, const char* text);
void add_linebreak(Html_Doc *htmldoc);
void output_result(Html_Doc *htmldoc);

char* generate_header(int level, const char* text);
char* generate_image(const char* image_name, const char* image_url, int width, int height);
char* generate_bold(const char* text);
char* generate_italic(const char* text);
char* generate_paragraph(const char* text);

#endif // __HEADER_GLOBAL__