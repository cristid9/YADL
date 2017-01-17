all:
	yacc -vd grammar.y
	flex -l lex.l
	gcc -Wall -o lang lex.yy.c y.tab.c -ll -lfl
