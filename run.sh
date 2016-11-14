lex lex.l
yacc -d parse.y
gcc lex.yy.c y.tab.c -lfl
cat test.txt | ./a.out
