%{
#define YYSTYPE char *
#include <string.h>
#include "miniMD2html.tab.h"
extern YYSTYPE yylval;
%}
%option yylineno

/* Flex definitions */
whitespace [ \t]+
newline [\n]+|{whitespace}[\n]+
/************* Start: add your definitions here */




/* End: add your definitions here */
%%
 /************* Start: add your rules here. */
 /* Start in the first column, no leading spaces.*/

 
 
 
 
 /* End: add your rules here */
{whitespace} { return T_BLANK; }
{newline} {return T_NEWLINE;}
%%
