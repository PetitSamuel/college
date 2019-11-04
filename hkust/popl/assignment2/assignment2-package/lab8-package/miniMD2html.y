%{
#include "global.h"
#include "stdlib.h"
#include "stdio.h"
#include <string.h>

#define YYSTYPE char *
extern int yylex();
int yywrap();
int yyerror(const char*);
int yyparse();
extern FILE *yyin;
Html_Doc *html_doc;
%}

/* Define tokens here */
%token T_BLANK T_NEWLINE BOLD ITALIC IMAGE_SIZE HEAD WORD PARAGRAPH
 /************* Start: add your tokens here */

 

/* End: add your tokens here */

%% /* Grammer rules and actions follow */
s: mddoc;
mddoc: /*empty*/ | mddoc paragraph;
paragraph: 
PARAGRAPH                 {add_element(html_doc, generate_paragraph($1));} 
|HEAD                      {create_and_add_header($1);}
;


/* End: add your grammar rules here */
%%
int get_header_level(char *s) {
  char * t; // first copy the pointer to not change the original
  int size = 0;

  for (t = s; *t == '#'; t++) {
    size++;
  }

  return size;
}

char *get_header_substr(char *s) {
  int amount = get_header_level(s);
  int len = strlen(s) - amount;
  char otherString[len]; 
  char * t = s + amount;
  int size = amount;

  for (int a = amount; a < len; a++) {
    otherString[a] = t++;
  }
  char * p = otherString;
  return p;
}

int create_and_add_header(char *s) {
  int a = get_header_level(s);
  char *ptr = get_header_substr(s);
  add_element(html_doc, generate_header(a, ptr));
  return 0;
}


int main(int argc, char *argv[]) {
  // yydebug = 1;

  FILE *fconfig = fopen(argv[1], "r");
  // make sure it is valid
  if (!fconfig) {
    printf("Error reading file!\n");
    return -1;
  }
  html_doc = new_html_doc();
  // set lex to read from file
  yyin = fconfig;
  int ret = yyparse();
  output_result(html_doc);
  del_html_doc(html_doc);
  return ret;
}

int length(char* s) {
  return strlen(s);
}


int yywrap(){
    return 1;
}

int yyerror(const char* s){
    extern int yylineno;
    extern char *yytext;
    printf("error while parsing line %d: %s at '%s', ASCII code: %d\n", yylineno, s, yytext, (int)(*yytext));
    return 1;
}
