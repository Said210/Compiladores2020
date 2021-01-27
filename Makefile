a.out: main.o lex.yy.o analisisSint.tab.o
		gcc main.o lex.yy.o analisisSint.tab.o -ll

main.o: main.c analisisSint.tab.c
		gcc -c main.c

lex.yy.o: lex.yy.c
		gcc -c lex.yy.c

analisisSint.tab.o: analisisSint.tab.c
		gcc -c analisisSint.tab.c 

lex.yy.c: analisisLex.l analisisSint.tab.c
		flex analisisLex.l

analisisSint.tab.c: analisisSint.y
		bison -d analisisSint.y

clear:
		rm -f a.out main.o lex.yy.o analisisSint.tab.o lex.yy.c analisisSint.tab.c analisisSint.tab.h

run: a.out
		./a.out
