all:
	yacc -vd --debug grammar.y
	flex --debug -l lex.l
	gcc -Wall -o lang lex.yy.c y.tab.c -ll -lfl -lm
