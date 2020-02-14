%{
#define YYSTYPE char *
#include <string.h>
#include "miniMD2html.tab.h"
extern YYSTYPE yylval;
#define printToken(desc, str) printf("%8s:%32s\n", desc, str)
%}
%option yylineno

/* Flex definitions */
whitespace [ \t]+
newline [\n]+|{whitespace}[\n]+
/************* Start: add your definitions here */
textword {char}+
char [a-zA-Z]|[:/.,']|[-]
header #|##|###|####|#####|######
int [0-9]+
%%
{header} {
    yylval = strdup(yytext);
    return HEADER;
}
{newline} {return T_NEWLINE;}
{whitespace} {return T_BLANK;}
{textword} {
    yylval = strdup(yytext);
    return WORD;
}
{int} {
    yylval = strdup(yytext);
    return NUMBER;
}
. {
    yylval = strdup(yytext);
    return *yytext;
}
%%
