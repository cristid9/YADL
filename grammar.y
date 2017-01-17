%{
#include  <stdio.h>
extern FILE* yyin;
extern char* yytext;

%}

%token VAR ID_NAME TYPE_STRING TYPE_BOOL TYPE_NUMBER
%token CONST VALUE_STRING VALUE_BOOL VALUE_NUMBER
%token DEFUNC

%token EQ NEQ LT GT LTE GTE AND OR NOT  
%token INC DEC 

%token FOR

%left '*' '/'
%left '+' '-'
%left '('
%left EQ NEQ LT GT LTE GTE AND OR

%nonassoc NOT
%nonassoc UMINUS
%nonassoc INC DEC

%%

program
    : block_content
    | func_declarations
    | func_definitions
    ;

block_content
    : declarations
    | assignments
    | stmt_expression ';'
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

increment_expression
    : INC stmt_expression
    | stmt_expression INC
    | DEC stmt_expression
    | stmt_expression DEC
    | ID_NAME
    ;

stmt_expression
    : increment_expression 
    | init_list 
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

assignments
    : init_list ';'
    ;

func_args_declarations
    : func_arg_declaration
    | func_args_declarations ',' func_arg_declaration
    ;

func_arg_declaration
    : VAR ':' type ID_NAME
    ;

func_declaration
    : DEFUNC ':' type ID_NAME '(' func_args_declarations ')' ';'
    ;

func_declarations
    : func_declaration
    | func_declarations func_declaration
    ;

func_definition
    : DEFUNC ':' type ID_NAME '(' func_args_declarations ')' '=' '{' block_content '}';

func_definitions
    : func_definition
    | func_definitions func_definition
    ;

var_declaration
    : VAR ':' type init_or_id_list ';' { printf("%s var\n", $1);  } 
    ;

const_declaration: CONST ':' type init_list ';' {printf("const\n");}
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
