%{

#include <stdio.h>
#include "y.tab.h"

%}

id_name [a-zA-Z]([a-zA-Z0-9])*
value_string \"([a-zA-Z0-9*+z=])*\"
value_number ([0-9]*[.])?[0-9]+

%%

"var"                   { return VAR;  }
"const"                 { return CONST; }
"string"                { return TYPE_STRING; }
"number"                { return TYPE_NUMBER; }
"bool"                  { return TYPE_BOOL; }
"true"                  { yylval.bVal = 1; return VALUE_BOOL; }
"false"                 { yylval.bVal = 0; return VALUE_BOOL; }
"defunc"                { return DEFUNC; }
"for"                   { return FOR; }
"while"                 { return WHILE; }
"if"                    { return IF; }
"class"                 { return CLASS; }
"print"                 { return PRINT; }
"sqrt"                  { return SQRT; }
"pow"                   { return POW; }

{value_number}          { yylval.nVal = atof(yytext);   return VALUE_NUMBER; }
{value_string}          { yylval.sVal = strdup(yytext); return VALUE_STRING; }
{id_name}               { return ID_NAME; }

","                     { return ','; }
":"                     { return ':'; }
";"                     { return ';'; }
"="                     { return '='; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"("                     { return '('; }
")"                     { return ')'; }
"{"                     { return '{'; }
"}"                     { return '}'; }
"["                     { return '['; }
"]"                     { return ']'; }

"=="                    { return EQ; }
"!="                    { return NEQ; }
"<"                     { return LT; }
">"                     { return GT; }
"<="                    { return LTE; }
">="                    { return GTE; }
"&&"                    { return AND; }
"||"                    { return OR; }
"!"                     { return NOT; }

"++"                    { return INC; }
"--"                    { return DEC; }

%%

