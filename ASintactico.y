/***
ESCUELA POLITÉCNICA NACIONAL
INGENIERÍA DE SISTEMAS
COMPILADORES 
PROYECTO SEGUNDO BIMESTRE - PARTE I
ANALIZADOR SINTÁCTICO
	Johanna Arias
	Samantha De la Cruz
FECHA: a 2016/06/30
GR_02
***/

	/*** Sección de declaraciones ***/
%{
/* Código en C que será copiado */
	#include <stdio.h>
	#include <stdlib.h>
	
	int yylex(void);
	void yyerror(char *);
	
	//int yystoppraser=0;
// extern FILE *fopen (const char *archEnt);
	extern FILE *yyin;
	FILE *archSal;
%}

/* Esto indica a Flex que lea sólo un fichero de entrada */
//%option noyywrap
/* Ordena a Flex que genere un analizador que mantenga el número de la línea actual*/
//%option yylineno

%token ID
%token IGUAL
%token ENTERO
%token FLOTANTE
%token STRING

%start expr
%%
	/*** Sección de reglas y acciones ***/
expr: 
        ID IGUAL valor          {fprintf(archSal,"Correcto");}
        ;
valor:	numero|STRING;
numero:	ENTERO|FLOTANTE;

%%
	/*** Sección de rutinas de usuario ***/


void yyerror(char *s)
{
	fprintf(stderr, "%s\n", s);
}

void main(void)
{
	yyin=fopen("emtrada.txt","r");
	archSal=fopen("salida.txt","w");
	yyparse();
	fclose(archSal);
}

