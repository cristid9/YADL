%{

#include <stdio.h>
#include "y.tab.h"

%}

id_name [a-zA-Z]([a-zA-Z0-9])*
value_string \"([a-zA-Z0-9*+z=])*\"
value_number [+-]?([0-9]*[.])?[0-9]+

%%

"var"                   { return VAR;  }
"const"                 { return CONST; }
"string"                { return TYPE_STRING; }
"number"                { return TYPE_NUMBER; }
"bool"                  { return TYPE_BOOL; }
"true"                  { return VALUE_BOOL; }
"false"                 { return VALUE_BOOL; }

{value_number}          { return VALUE_NUMBER; }
{value_string}          { return VALUE_STRING; }
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


%%

