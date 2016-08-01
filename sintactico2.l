/***
ESCUELA POLITÉCNICA NACIONAL
INGENIERÍA DE SISTEMAS
COMPILADORES 
PROYECTO PRIMER BIMESTRE - ETAPA 2: ANALIZADOR LÉXICO PARA EL ANALIZADOR SINTÁCTICO
ANALIZADOR LÉXICO
	Johanna Arias
	Samantha De la Cruz
FECHA: a 2016/06/30
GR_02
***/

	/*** Sección de declaraciones ***/
%{
	#include <stdlib.h> 
	void yyerror(char *);
	int funcion();
	#include "sintactico2.tab.h"
	int linea=1;
	extern char *yytext;// yytext reconoce el lexema del último token reconocido
	FILE *archSal1;
	FILE *archSal;
	
%}

/* Ordena a Flex que genere un analizador que mantenga el número de la línea actual*/
%option yylineno 


caresp 		":"|"!"|"&"|"$"
compar 		">"|"<"">="|"<="|"=="|"!="|"&&"|"||"
iden 		[a-z]([a-zA-Z]|[0-9])*
digito 		[0-9]
float 		[0-9]*"."[0-9]+
bool 		"True"|"False"|"true"|"false"|"TRUE"|"FALSE"
char 		"'"[a-zA-Z]"'"
string 		\"[^\n"]+\"
coms 		"//".*?
comc 		"/*"[^"*/"]*
tipo_de_dato	"int"|"double"|"float"|"char"|"string"|"bool"


%%

"#include" 			return INCLUDE;
"<"[a-z]+".h>" 			return LIBRERIA;
"if"      			return IF;
"for"      			return FOR;
"else"     			return ELSE;
"return"  			return RETURN;
{tipo_de_dato}			{fprintf(archSal1,"|    %s \t|",yytext);
				return TIPODEDATO;}
"void"    			return VOID;
"then"    			return THEN;
"while"   			return WHILE;
"do"      			return DO;
"input"   			return INPUT;
"output"  			return OUTPUT;
{iden} 				{fprintf(archSal1,"    %s  \t|\n",yytext );
				return IDENTIFICADOR;}
"="				return IGUAL;
{digito}+|"+"{digito}+	 	return ENTEROPOSITIVO;
"-"{digito}+			return ENTERONEGATIVO;
{float} 			return FLOTANTE;
{bool} 				return BOOL;
{caresp}			return CARRESP;
{compar} 			return COMPAR;			
{char}				return CARACTER;
{string} 			return CADENA;
"+"|"-"				return MASMENOS;
"*"|"/"				return DIMULTI;
";"				return PUNTO_Y_COMA;
"{"				return LLAV_ABIERTA;
"}"				return LLAV_CERRADA;
"("				return PAR_ABIERTO;
")"				return PAR_CERRADO;
"["				return COR_ABIERTO;
"]"				return COR_CERRADO;
","				return COMA;
" "|\t				;
\n				{linea++; fprintf(archSal, "\n");}
.				{fprintf(archSal, "--ERROR linea %d\n", yylineno);} /* Ignora todos los demás caracteres e imprime la línea de error */
				
%%

	int yywrap(void){
		return 1;
}
