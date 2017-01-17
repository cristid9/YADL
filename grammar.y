%{
#include  <stdio.h>
extern FILE* yyin;
extern char* yytext;

%}

%token VAR ID_NAME TYPE_STRING TYPE_BOOL TYPE_NUMBER
%token CONST VALUE_STRING VALUE_BOOL VALUE_NUMBER

%left '*' '/'
%left '+' '-'

%nonassoc UMINUS

%%

program
    : declarations
    ;

declarations
    : declaration
    | declarations declaration
    ;

declaration
    : var_declaration
    | const_declaration
    ;

value
    : VALUE_BOOL
    | VALUE_STRING
    ;

arithmetic_expression
    : arithmetic_expression '*' arithmetic_expression
    | arithmetic_expression '/' arithmetic_expression
    | arithmetic_expression '+' arithmetic_expression
    | arithmetic_expression '-' arithmetic_expression
    | '(' arithmetic_expression ')'
    | VALUE_NUMBER
    ;
   
initializer
    : value
    | arithmetic_expression
    ;

initialization
    : ID_NAME '=' initializer
    ;

init_list
    : initialization
    | init_list ',' initialization
    ;

init_or_id
    : initialization
    | ID_NAME
    ;

init_or_id_list
    : init_or_id
    | init_or_id_list ',' init_or_id
    ;

var_declaration
    : VAR ':' type init_or_id_list ';' { printf("%s booyah\n", $1);  } 
    ;

const_declaration: CONST ':' type init_list ';' {printf("koskos\n");}
    ;

type: TYPE_NUMBER 
    | TYPE_STRING
    | TYPE_BOOL
    ;

%%
void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}

int main(int argc, char** argv[])
{

    yyparse();
    return 0;
}
