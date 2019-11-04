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
textwork {char}+|{integer}
line {whitespace}*{textwork}{whitespace}*
fullLine {line}+
digit [0-9]
integer {digit}+
char [a-zA-Z]|[:/.,']|[-]
header #|##|###|####|#####|######
bold [\*]{2}
italic [_]
imgsize [=]{integer}[@]{integer}
boldText {boldSymbol}{line}*{boldSymbol}
headerLine {header}{fullLine}
imageName [\!][[]{fullLine}[]]
/* End: add your definitions here */
%%
{imgsize} {printToken("IMAGE W/H", yytext);}
{imageName} {printToken("NAME", yytext);}
{headerLine} {printToken("HEADER", yytext);}
{fullLine} {
    printToken("PIECE OF TEXT ", yytext);
    yylval = (char*)malloc(sizeof(char)*strlen(yytext));strcpy(yylval, yytext);return PARAGRAPH;
}
{bold} {printToken("BOLD", "**");}
{italic} {printToken("ITALIC", yytext);}
%%
