/***
ESCUELA POLITÉCNICA NACIONAL
INGENIERÍA DE SISTEMAS
COMPILADORES 
PROYECTO SEGUNDO BIMESTRE - ETAPA 2: ANALIZADOR SINTÁCTICO
ANALIZADOR LÉXICO
	Johanna Arias
	Samantha De la Cruz
FECHA: a 2016/06/30
GR_02
***/

	/*** Sección de declaraciones ***/
%{
	#include <stdio.h>
	#include <stdlib.h> 
    	extern int yylex(void); 
	void yyerror(char *);
	extern FILE *yyin;
	extern int linea;
	extern char *yytext;
	//extern yylineno;
	FILE *archSal;//archivo para imprimir declaraciones
   	FILE *archSal1;//archivo que imprime la tabla se símbolos
%}

	//declaraciones de símbolos de gramática terminales
	//los no t erminales irían con %type
%start programa //indica el símbolo de inicio de la gramática
%token INCLUDE
%token IGUAL
%token LIBRERIA
%token TIPODEDATO
%token IF
%token FOR
%token ELSE
%token RETURN
%token VOID
%token THEN
%token WHILE
%token DO
%token INPUT
%token OUTPUT
%token ENTEROPOSITIVO
%token ENTERONEGATIVO
%token FLOTANTE
%token BOOL
%token CARRESP
%token COMPAR
%token IDENTIFICADOR
%token CARACTER 
%token CADENA
%token MASMENOS
%token DIMULTI
%token COMA
%token LLAV_ABIERTA
%token LLAV_CERRADA
%token PAR_ABIERTO
%token PAR_CERRADO
%token COR_ABIERTO
%token COR_CERRADO
%token PUNTO_Y_COMA


%%

programa:
	declaracionG			
	|definicionFuncion		{fprintf(archSal,"DefinicionFuncion");}		
	|declaracionG programa		
	|definicionFuncion programa	{fprintf(archSal,"DefinicionFuncion");}
	;

declaracionG:
	declaracionLibreria	{fprintf(archSal,"DeclaracionLibreria");}
	|declaracionVariable	{fprintf(archSal,"DeclaracionVariable1");}
	|declaracionFuncion	{fprintf(archSal,"DeclaracionFuncion");}	
	;

declaracionLibreria:
	INCLUDE LIBRERIA	
	;

declaracionVariable:		
	TIPODEDATO IDENTIFICADOR IGUAL valor PUNTO_Y_COMA					//{fprintf(archSal1,"%s \t|\t %s \t|\n",yytext,yytext);}
	|TIPODEDATO IDENTIFICADOR IGUAL IDENTIFICADOR PUNTO_Y_COMA 			//{fprintf(archSal1,"%s \t|\t %s \t|\n",yytext,yytext);}
	|TIPODEDATO IDENTIFICADOR PUNTO_Y_COMA 						//{fprintf(archSal1,"%s \t|\t %s \r|\n",yytext,yytext);}
	|TIPODEDATO IDENTIFICADOR COR_ABIERTO ENTEROPOSITIVO COR_CERRADO PUNTO_Y_COMA 	//{fprintf(archSal1,"%s \t|\t %s \t|\n",yytext,yytext);}
	;			
  
declaracionFuncion:
	TIPODEDATO IDENTIFICADOR PAR_ABIERTO parametroFuncion PAR_CERRADO PUNTO_Y_COMA 		//{fprintf(archSal1,"%s \t|\t %s \t|",yytext,yytext);}
	|TIPODEDATO IDENTIFICADOR PAR_ABIERTO PAR_CERRADO PUNTO_Y_COMA				//{fprintf(archSal1,"%s \t|\t %s \t|",yytext,yytext);}
	|VOID IDENTIFICADOR PAR_ABIERTO parametroFuncion PAR_CERRADO PUNTO_Y_COMA
	|VOID IDENTIFICADOR PAR_ABIERTO PAR_CERRADO PUNTO_Y_COMA
	;

definicionFuncion:
	TIPODEDATO IDENTIFICADOR PAR_ABIERTO parametroFuncion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA 
	|TIPODEDATO IDENTIFICADOR PAR_ABIERTO PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA			
	|VOID IDENTIFICADOR PAR_ABIERTO parametroFuncion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA  	
	|VOID IDENTIFICADOR PAR_ABIERTO PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA			
	;

parametroFuncion:
	TIPODEDATO IDENTIFICADOR				//{fprintf(archSal1,"\n");}
	|TIPODEDATO IDENTIFICADOR COMA parametroFuncion
	;

bloque:
	llamadaIf			
	|llamadaWhile			
	|llamadaDoWhile			
	|llamadaFuncion			
	|declaracionVariable 		{fprintf(archSal,"DeclaracionVariable2");}	
	|usoVariable			{fprintf(archSal,"DeclaracionVariable3");}		
	|llamadaIf bloque			
	|llamadaWhile bloque			
	|llamadaDoWhile	bloque		
	|llamadaFuncion	bloque		
	|declaracionVariable bloque	{fprintf(archSal,"DeclaracionVariable2");}		
	|usoVariable bloque			
	;

llamadaIf:
	IF PAR_ABIERTO condicion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA					{fprintf(archSal,"DeclaracionIF");}	
	|IF PAR_ABIERTO condicion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA ELSE LLAV_ABIERTA bloque LLAV_CERRADA 	{fprintf(archSal,"DeclaracionIF");}		
	;

llamadaWhile:
	WHILE PAR_ABIERTO condicion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA	{fprintf(archSal,"DeclaracionWHILE");}				
	;

llamadaDoWhile:
	DO LLAV_ABIERTA bloque LLAV_CERRADA WHILE PAR_ABIERTO condicion PAR_CERRADO PUNTO_Y_COMA	{fprintf(archSal,"DeclaracionDoWhile");}		
	;
llamadaFuncion:
	IDENTIFICADOR PAR_ABIERTO parametroLlamada PAR_CERRADO PUNTO_Y_COMA	{fprintf(archSal,"LlamadaFuncion");}	
	|IDENTIFICADOR PAR_ABIERTO PAR_CERRADO PUNTO_Y_COMA			{fprintf(archSal,"LlamadaFuncion");}	
	;

parametroLlamada:
	usoAux1					
	|usoAux1 COMA parametroLlamada		
	;

condicion:      
	BOOL				
	|usoAux1 COMPAR usoAux1			
	|llamadaFuncion				
	|llamadaFuncion COMPAR usoAux1		
	|llamadaFuncion COMPAR llamadaFuncion	
	;

valor:		
	enteros		
	|FLOTANTE 	
	|CARACTER 
	|CADENA		
	;

usoVariable:
	IDENTIFICADOR IGUAL usoAux2 	//{fprintf(archSal1,"%s \n",yytext);}	
	;

enteros:
	ENTEROPOSITIVO	
	|ENTERONEGATIVO	
	;

operacion:
	MASMENOS	{$$=$1;}	
	|DIMULTI
	;

usoAux1:
	IDENTIFICADOR 	{fprintf(archSal1,"%s \t|\n",yytext); }
	|valor		
	;

usoAux2:
	usoAux1 PUNTO_Y_COMA		
	|usoAux1 operacion usoAux2	
	;

%%
	void yyerror(char *s)
	{ 
   		fprintf(stderr, "Error en la Linea: %d\n",linea); 
	} 
	int main(void)
	{ 
		yyin=fopen("entrada.txt","r");
		archSal=fopen("salidaSintactica.txt","w");
		archSal1=fopen("tabladeSimbolos.txt","w");
		//
		fprintf(archSal1,"\t TABLA DE SÍMBOLOS\n");
		fprintf(archSal1,"+---------------+---------------+\n");
		fprintf(archSal1,"|    TIPO \t|    VARIABLE  \t|\n");
		fprintf(archSal1,"+---------------+---------------+\n");
		//
	    	yyparse();  //llamada al analizador sintáctico
		fclose(archSal);
	} 
