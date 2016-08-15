#!/bin/bash

echo "Generando lex.yy.c"                               &&
flex scanner.l                                     	&&
echo "Flex -------------------------------- OK"         &&

echo ""                                                 &&
echo "Generando parser.tab.h y parser.tab.c"            &&
bison -d -v parser.y                                 &&
echo "Bison ------------------------------- OK"         &&

echo ""                                                 &&
echo "Compilando los archivos"                          &&
gcc tablasimbolos.c parser.tab.c lex.yy.c -lfl -ggdb -o exec -Wall -Wextra   &&
echo "GCC --------------------------------- OK"         &&

echo ""
echo "Para leer de un archivo específico digite:"
echo "	./exec <nombre_de_archivo>"
echo "	ejemplo: ./exec input_scanner"
