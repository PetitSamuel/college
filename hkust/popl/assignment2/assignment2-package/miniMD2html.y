%{
#include "global.h"
#include "stdlib.h"
#include "stdio.h"
#define YYSTYPE char *
extern int yylex();
int yywrap();
int yyerror(const char*);
int yyparse();
extern FILE *yyin;
Html_Doc *html_doc;
%}

/* Define tokens here */
%token T_BLANK T_NEWLINE
 /************* Start: add your tokens here */

 

/* End: add your tokens here */

%% /* Grammer rules and actions follow */
s: mddoc;
mddoc: /*empty*/ | mddoc paragraph;
paragraph:
T_NEWLINE                 {add_linebreak(html_doc);} 
| pcontent T_NEWLINE   {add_element(html_doc, $1); free($1);}
;
 /************* Start: add your grammar rules here */





/* End: add your grammar rules here */
%%

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


int yywrap(){
    return 1;
}

int yyerror(const char* s){
    extern int yylineno;
    extern char *yytext;
    printf("error while parsing line %d: %s at '%s', ASCII code: %d\n", yylineno, s, yytext, (int)(*yytext));
    return 1;
}
