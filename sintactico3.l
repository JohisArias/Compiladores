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
	int linea=1;//contador de línea
	extern char *yytext;// yytext reconoce el lexema del último token reconocido
	FILE *archSal;//para imprimir declaraciones
	FILE *archSal1;//para imprimir tabla de símbolos
	
%}

/* Ordena a Flex que genere un analizador que mantenga el número de la línea actual*/
%option yylineno 

espacio	" "|\t
digito	[0-9]
letra	[a-z|A-Z]
string	\"[^\n"]+\"

caracteres_especiales 		"!"|"&"|"$"
comparativos 			">"|"<"">="|"<="|"=="|"!="|"&&"|"||"
bool 				"True"|"False"|"true"|"false"|"TRUE"|"FALSE"
comen_simple 			"//".*?
comen_compuesto 		"/*"[^"*/"]*
tipo_de_dato			"int"|"double"|"float"|"char"|"string"|"bool"


%%

{espacio}+			;//no hace nada
"#include" 			return INCLUDE;
"<"[a-z]+".h>" 			return LIBRERIA;
"if"      			return IF;
"for"      			return FOR;
"else"     			return ELSE;
"return"  			return RETURN;
{tipo_de_dato}			{fprintf(archSal1,"\n|    %s \t|",yytext);
				return TIPO_DE_DATO;}
"void"    			return VOID;
"then"    			return THEN;
"while"   			return WHILE;
"do"      			return DO;
"input"   			return INPUT;
"output"  			return OUTPUT;
[a-z]{letra}*|{digito}*		{fprintf(archSal1,"  %s",yytext );
				return IDENTIFICADOR;}
{digito}+|"+"{digito}+	 	{fprintf(archSal1,"  %s ",yytext);
				return ENTEROPOSITIVO;}
"-"{digito}+			{fprintf(archSal1,"  %s ",yytext);
				return ENTERONEGATIVO;}
{digito}*"."{digito}+		{fprintf(archSal1,"  %s ",yytext);
				return FLOAT;}
{bool} 				{fprintf(archSal1,"  %s ",yytext);
				return BOOL;}
{caracteres_especiales}		return CARACTER_ESPECIAL;
{comparativos} 			return COMPARATIVOS;			
"'"{letra}"'"			{fprintf(archSal1,"  %s",yytext);
				return CHAR;}
{string} 			{fprintf(archSal1,"  %s",yytext);
				return STRING;}
"+"				return MAS;
"-"				return MENOS;
"*"				return MULTIPLICACION;
"/"				return DIVISION;
"="				{fprintf(archSal1,"  %s",yytext);
				return IGUAL;}
":"				{fprintf(archSal1," %s",yytext);
				return DOS_PUNTOS;}
","				return COMA;
";"				{fprintf(archSal1,"%s \t|",yytext);
				return PUNTO_Y_COMA;}
"{"				return LLAV_ABIERTA;
"}"				return LLAV_CERRADA;
"("				return PAR_ABIERTO;
")"				return PAR_CERRADO;
"["				{fprintf(archSal1,"  %s",yytext);
				return COR_ABIERTO;}
"]"				{fprintf(archSal1,"  %s",yytext);
				return COR_CERRADO;}
\n				{linea++; fprintf(archSal, "\n");}
.				{fprintf(archSal, "--ERROR linea %d\n", yylineno);} /* Ignora todos los demás caracteres e imprime la línea de error */
				
%%

	int yywrap(void){
		return 1;
}
