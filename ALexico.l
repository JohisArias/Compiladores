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
	FILE *archSal;
	FILE *archEnt;
%}

/* Esto indica a Flex que lea sólo un fichero de entrada */
%option noyywrap
/* Ordena a Flex que genere un analizador que mantenga el número de la línea actual*/
%option yylineno 


int numLinea=0;
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
\n				fprintf(archSal,"\n"); /* imprime un enter al final de cada línea */
				
{digito}+|"-"{digito}		fprintf(archSal, "ENTERO ");
{digito}*"."{digito}+		fprintf(archSal, "FLOTANTE "); /* num real */
"true"|"TRUE"|"false"|"FALSE"	fprintf(archSal, "BOOLEAN ");
"'".{1}"'"			fprintf(archSal, "CHAR ");
{string}			fprintf(archSal, "STRING ");
"if"|"else if"|"else"		fprintf(archSal, "CONDICIONAL ");
"then"				fprintf(archSal, "THEN ");
"for"|"while"|"do"		fprintf(archSal, "BUCLE ");
{palabra_reservada}		fprintf(archSal, "PALAB_RESERVADA ");

[a-z]{letra}*|{digito}*		fprintf(archSal, "ID ");

"+"|"-"|"*"|"/"|"%"		fprintf(archSal, "OPERADOR ");
{operandos_compuestos}		fprintf(archSal, "OP_COMPUESTO ");

";"				fprintf(archSal, "PUNTO_Y_COMA ");
"("				fprintf(archSal, "PAR_ABIERTO ");
")"				fprintf(archSal, "PAR_CERRADO ");
"["				fprintf(archSal, "COR_ABIERTO ");
"]"				fprintf(archSal, "COR_CERRADO ");
"{"				fprintf(archSal, "LLAV_ABIERTA ");
"}"				fprintf(archSal, "LLAV_CERRADA ");
{caracteres_especiales}		fprintf(archSal, "CARACT_ESPECIAL ");

.				fprintf(archSal, "ERROR "); /* Ignora todos los demás caracteres e imprime la línea de error */

%%
	/*** Sección de código en C ***/
void main()
{
    yyin=fopen("ArchivoEntrada.txt","r");//read
    archSal=fopen("ArchivoSalida.txt","w");//write
   /* Ejecuta el 'lexer' y después temina */
    yylex();
    fclose(archSal);
}
