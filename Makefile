all:
	@echo "building lang"
	@bison -vd --debug grammar.ypp -o grammar.cpp 
	@flex --outfile=lex.yy.cpp  --debug -l lex.l 
	@g++ -Wall -o lang lex.yy.cpp grammar.cpp -ll -lfl -lm 
