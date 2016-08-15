#/bin/bash
bison -d sintactico2.y
flex sintactico2.l
gcc lex.yy.c sintactico2.tab.c
./a.out
