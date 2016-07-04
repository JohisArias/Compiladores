/***
ESCUELA POLITÉCNICA NACIONAL
INGENIERÍA DE SISTEMAS
COMPILADORES 
PROYECTO PRIMER BIMESTRE
ANALIZADOR LÉXICO
	Johanna Arias
	Samantha De la Cruz
FECHA: a 2016/06/13
GR_02
***/

	/*** Sección de declaraciones ***/
%{
/* Código en C que será copiado */
	#include <stdio.h>
	#include <stdlib.h>
	void yyerror(char *);
	int funcion();
	#include "ASintactico.tab.h" 
	//FILE *archSal;
	//FILE *archEnt;
%}

/* Esto indica a Flex que lea sólo un fichero de entrada */
%option noyywrap
/* Ordena a Flex que genere un analizador que mantenga el número de la línea actual*/
%option yylineno 

espacio	" "|\t
digito	[0-9]
letra	[a-z|A-Z]
string	\"[^\n"]+\"
/*lib	"#"[a-z]+"<" [a-z]+".h>"*/
   
 
palabra_reservada	"int"|"float"|"double"|"bool"|"char"|"string"|"if"|"then"|"else"|"while"|"do"|"input"|"output"|"return"|"void"

caracteres_especiales	","|";"|":"|"("|")"|"["|"]"|"{"|"}"|"+"|"-"|"*"|"/"|"<"|">"|"="|"!"|"&"|"$"

operandos_compuestos	"<="|">="|"=="|"!="|"&&"|"||"


%%
	/*** Sección de reglas ***/

{espacio}+	     		; /* no cuenta los expacios */
\n				return "\n"; /* imprime un enter al final de cada línea */
				
{digito}+|"-"{digito}		return "ENTERO ";
{digito}*"."{digito}+		return "FLOTANTE "; /* num real */
"true"|"TRUE"|"false"|"FALSE"	return "BOOLEAN ";
"'".{1}"'"			return "CHAR ";
{string}			return "STRING ";
"if"|"else if"|"else"		return "CONDICIONAL ";
"then"				return "THEN ";
"for"|"while"|"do"		return "BUCLE ";
{palabra_reservada}		return "PALAB_RESERVADA ";

[a-z]{letra}*|{digito}*		return "ID ";

"+"|"-"|"*"|"/"|"%"		return "OPERADOR ";
"="|" = "|"= "|" ="		return "IGUAL";
{operandos_compuestos}		return "OP_COMPUESTO ";

";"				return "PUNTO_Y_COMA ";
"("				return "PAR_ABIERTO ";
")"				return "PAR_CERRADO ";
"["				return "COR_ABIERTO ";
"]"				return "COR_CERRADO ";
"{"				return "LLAV_ABIERTA ";
"}"				return "LLAV_CERRADA ";
{caracteres_especiales}		return "CARACT_ESPECIAL ";

.				return("--ERROR en la linea %d\n", yylineno); /* Ignora todos los demás caracteres e imprime la línea de error */

%%
	/*** Sección de código en C ***/
int yywrap(void) { 
    return 1; 
}
