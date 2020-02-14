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

%token T_BLANK T_NEWLINE HEADER WORD NUMBER


%%
s: mddoc;
mddoc: /*empty*/ | mddoc paragraph;
paragraph: T_NEWLINE {add_linebreak(html_doc);}
| pcontent T_NEWLINE {add_element(html_doc, $1);};

pcontent: 
header {
  $$ = $1;
}
| rftext {
  $$ = generate_paragraph($1);
}
;
header: 
headermark blanks rftext {$$ = generate_header(strlen($1), $3);};
headermark: HEADER {$$ = $1;};
rftext: 
rftext blanks rftextword {
   $$ = strappend(strappend($1, " "), $3); 
}
| rftext rftextword  {
   $$ = strappend($1, $2); 
}
| rftextword {$$ = $1;};

rftextword: textnum {$$ = $1;}
| format {$$ = $1;}
| image {$$ = $1;};
image: '!''[' text ']''(' text '=' NUMBER '@' NUMBER ')' {
  $$ = generate_image($3, $6, atoi($8), atoi($10));
};
format: '*''*' text '*''*' {$$ = generate_bold($3);}
| '_' text '_' {$$ = generate_italic($2);}
| '*''*' format '*''*' {$$ = generate_bold($3);}
| '_' format '_' {$$ = generate_italic($2);};
text: text blanks textnum {
   $$ = strappend(strappend($1, " "), $3); 
}
| text textnum {
   $$ = strappend($1, $2); 
}
|textnum {$$ = $1;};
textnum: WORD
| NUMBER;
blanks: T_BLANK {$$ = " ";};
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
