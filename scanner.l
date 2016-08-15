%{
	#include <string.h>	// for strdup (tries to allocate and copies the string if ok)
	#include <stdlib.h>	// for atoi and atof
	#include "parser.tab.h"
	
	int linea=1, chars=0, error=0;

	voidentificador count_lb(char *str, int leng, int *c, int *l);
%}

/** EXPRESIONES REGULARES **/
digito 		[0-9]
num		{digito}+
real		{digito}+'.'{digito}+
bool		"true"
letra 		[a-zA-Z]
identificador   [a-z]("_"|{letra}|{digito})*
operadores	("+"|"-"|"*"|"/"|"++"|"--")
op_logicos	("!"|"<"|">"|"=="|"&&"|"||")
igual		("=")


espacio		[" "\t]
enter	\n|\v\r

 /* Scope and statement delimiters */
agrupadores		"{"|"}"|"("|")"|"["|"]"
coma	(",")
punto_y_coma	(";")
 /* Comment and string [.\n]* no comment  */
comment		("//".*\n)
string		(\"[^\"]*\")

 /* Basic data type */
 /*dtype		"int"|"float"*/

%option noyywrap
%option noinput
%option nounput


%%

 /*	KEYWORDS	*/
main	{ chars += yyleng; return (MAIN); }
if	{ chars += yyleng; return (IF); }
else	{ chars += yyleng; return (ELSE); }
do	{ chars += yyleng; return (DO); }
while	{ chars += yyleng; return (WHILE); }
for	{ chars += yyleng; return (FOR); }
break	{ chars += yyleng; return (BREAK); }
print 	{ chars += yyleng; return (PRINT); }
return	{ chars += yyleng; return (RETURN); }

{comment} { linea++; } //comentario

int {
	chars += yyleng;
	return (TD_INT);
	}

float {
	chars += yyleng;
	return (TD_FLOAT);
	}

boolean {
	chars += yyleng;
	return (TD_BOOL);
	}

 /*	INVALidentificador	*/
({num}|{real}|{bool}){identificador} {
	printf("( %3d : %-3d ) identificador inválid identificador: %s\n", linea, chars, yytext);
	chars += yyleng;
	error++;
}


 /*	NUMEROS	*/
{num} {
	yylval.integer = (int)atoi(yytext);
	chars += yyleng;
	return (ENTERO);
}
{real} {
	yylval.real = (float)atof(yytext);
	chars += yyleng;
	return (FLOTANTE);
}

{bool} {
	yylval.lexeme =  (char *)strdup(yytext);
	chars += yyleng;
	return (BOOLEAN);
}

 /*	identificadorENTIFIER	*/
{identificador} {
	yylval.lexeme = (char *)strdup(yytext);
	chars += yyleng;
	return (identificador);
}


 /*	OPERADORES	*/
"+" |
"-" |
"*" |
"/" { chars++; return yytext[0]; }

"++" { chars+=yyleng; return MAS_MAS; }
"--" { chars+=yyleng; return MENOS_MENOS; }

"<"  { chars+=yyleng; return MENOR_QUE; }
">"  { chars+=yyleng; return MAYOR_QUE; }
"<=" { chars+=yyleng; return MENOR_IGUAL; }
">=" { chars+=yyleng; return MAYOR_IGUAL; }
"==" { chars+=yyleng; return IGUAL_IGUAL; }
"&&" { chars+=yyleng; return AND; }
"||" { chars+=yyleng; return OR; } 
"!"  { chars+=yyleng; return NOT; }

{igual} { chars++; return (yytext[0]); }

 /*	DELIMITADORES	*/
({agrupadores}|{coma}|{punto_y_coma}) { chars++; return (yytext[0]); }


 /*	OTROS	*/
{string} { count_lb(yytext, yyleng, &chars, &linea); return (STRING); }

{espacio} { chars++; }

{enter} {
	chars = 0;
	linea++;
}


 /*	ERROR DESCONOCIDO	*/
. {
	printf("( %3d : %-3d ) Token no reconocidentificadoro\n", linea, chars);
	chars++;
	error++;
}

%%

// Cuenta los enters o saltos de línea
voidentificador count_lb(char *str, int leng, int *c, int *l) {
	int i;

	for(i=0; i<leng; i++) {
		(*c)++;
		if(str[i] == '\n') {
			(*l)++;
			*c = 0;
		}
	}
}
