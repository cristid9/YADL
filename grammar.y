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

%token FOR WHILE IF
%token CLASS
%token PRINT SQRT POW

%left '*' '/'
%left '+' '-'
%left '('
%left EQ NEQ LT GT LTE GTE AND OR

%nonassoc NOT
%nonassoc UMINUS
%nonassoc INC DEC

%%

program
    : func_declarations
    | func_definitions
    | block_content
    | class_definitions
    ;

block_content
    : declarations
    | assignments
    | increment_expressions
    | logical_expressions
    | for_stmt
    | while_stmt
    | if_stmt
    | func_call
    | std_funcs_list
    ;

declarations
    : declaration
    | declarations declaration
    ;

declaration
    : var_declaration
    | const_declaration
    | array_declaration
    ;

value
    : VALUE_BOOL
    | VALUE_STRING
    ;

increment_expression
    : INC increment_expression
    | increment_expression INC
    | DEC increment_expression
    | increment_expression DEC
    | ID_NAME
    ;

increment_expressions
    : increment_expression ';'
    | increment_expressions  increment_expression ';'
    ;

logical_expression
    : logical_expression EQ logical_expression
    | logical_expression NEQ logical_expression
    | logical_expression LT logical_expression
    | logical_expression GT logical_expression
    | logical_expression LTE logical_expression
    | logical_expression GTE logical_expression
    | logical_expression AND logical_expression
    | logical_expression OR logical_expression
    | NOT logical_expression
    | '(' logical_expression ')'
    | value
    | VALUE_NUMBER
    | ID_NAME
    ;

logical_expressions
    : logical_expression ';'
    | logical_expressions logical_expression ';'
    ;

for_stmt
    : FOR '(' initialization ';' logical_expression ';' increment_expression ')' '{' block_content '}'
    ;

while_stmt
    : WHILE '(' logical_expression ')' '{' block_content '}'
    ;

if_stmt
    : IF '(' logical_expression ')' '{' block_content '}'
    ;

func_call_args
    : arithmetic_expression
    | func_call_args ',' arithmetic_expression
    ;

class_definition
    : CLASS ID_NAME '{' declarations func_definitions '}'
    ;

class_definitions
    : class_definition
    | class_definitions class_definition
    ;

func_call
    : ID_NAME '(' func_call_args ')' ';'

array_declaration
    : VAR ':' type ID_NAME '[' VALUE_NUMBER ']' ';'
    ;

array_assignment
    : ID_NAME '[' VALUE_NUMBER ']' '=' initializer ';'
    | ID_NAME '[' ID_NAME ']' '=' initializer ';'
    ;

arithmetic_expression
    : arithmetic_expression '*' arithmetic_expression
    | arithmetic_expression '/' arithmetic_expression
    | arithmetic_expression '+' arithmetic_expression
    | arithmetic_expression '-' arithmetic_expression
    | '(' arithmetic_expression ')'
    | VALUE_NUMBER
    ;

std_funcs_list
    : std_funcs
    | std_funcs_list std_funcs
    ;

std_funcs
    : std_print
    | std_pow
    | std_sqrt
    ;

std_func_args
    : arithmetic_expression
    | ID_NAME
    ;

std_print
    : PRINT '(' std_func_args ')' ';'
    ;

std_pow
    : POW '(' std_func_args ',' std_func_args ')' ';'
    ;

std_sqrt
    : SQRT '(' std_func_args ')' ';'
    ;

initializer
    : value
    | arithmetic_expression
    | std_funcs
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
    | array_assignment
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
    : DEFUNC ':' type ID_NAME '(' func_args_declarations ')' '=' '{' block_content '}'
    ;

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
