%{
	#include <stdio.h>
	#include <stdlib.h> 
   	int yylex(void); 
    	void yyerror(char *);
	extern FILE *yyin;
 	FILE *archSal;

	int numLinea=0;
%}

//%option yylineno 
%token INCLUDE
%token IGUAL
%token LIBRERIA
%token IF
%token FOR
%token ELSE
%token RETURN
%token BOOLEANO
%token STRING
%token ENTERO
%token VOID
%token TIPODEDATOFLOTANTE
%token TIPODEDATOCHAR
%token THEN
%token WHILE
%token DO
%token INPUT
%token OUTPUT
%token ENTERO
%token FLOTANTE
%token BOOLEANO
%token CARRESP
%token COMPAR
%token IDENTIFICADOR
%token CARACTER 
%token CADENA
%token MASMENOS
%token DIMULTI
%token COMA
%token KEYOP
%token KEYCL

%token ParetOP
%token ParetCL

%token BracketOP
%token BracketCL
%token FinCommand

%token SALTO_LINEA

%token ERROR

%start programa
%%

programa:
		declaracionG 
		|main		{fprintf(archSal,"DeclaracionMain \n");}
		|funcion  		
		|declaracionG programa	
		|funcion programa
		|main programa
		|stament
		|stament programa
	
		
				;

//declaracionG: TIPODEDATOENTERO IDENTIFICADOR IGUAL IDENTIFICADOR FinCommand	{fprintf(archSal,"declaracionEntero");};

//libreria: INCLUDE LIBRERIA FinCommand ;  
stament:	IDENTIFICADOR IGUAL dato FinCommand
		| IDENTIFICADOR IGUAL dato MASMENOS dato FinCommand;

  																																																																	
funcion:
		IDENTIFICADOR ParetOP declaracionParametro ParetCL FinCommand {fprintf(archSal,"LlamadaFuncion \n");}
		|tipoDeDato IDENTIFICADOR ParetOP declaracionParametro ParetCL KEYOP programa KEYCL {fprintf(archSal,"DeclaracionFuncion \n");}
		|tipoDeDato IDENTIFICADOR ParetOP declaracionParametro ParetCL KEYOP  KEYCL {fprintf(archSal,"DeclaracionFuncion \n");}
		|IDENTIFICADOR ParetOP  ParetCL FinCommand {fprintf(archSal,"LlamadaFuncion \n");}
		
		|tipoDeDato IDENTIFICADOR ParetOP ParetCL KEYOP programa KEYCL {fprintf(archSal,"DeclaracionFuncion \n");}
		|tipoDeDato IDENTIFICADOR ParetOP ParetCL KEYOP  KEYCL {fprintf(archSal,"DeclaracionFuncion \n");}		
;
declaracionG:
		declaracionLibreria {fprintf(archSal,"DeclaraciondeLibreria \n");}
		|declaracionFuncion 
		|declaracionVariable 
		|lazos
		;
lazos:		IF ParetOP condicion ParetCL KEYOP programa KEYCL{fprintf(archSal,"IF \n");}
		|ELSE ParetOP condicion ParetCL KEYOP programa KEYCL {fprintf(archSal,"ELSE \n");}
		|ELSE KEYOP programa KEYCL		{fprintf(archSal,"ELSE \n");}
		


;
condicion:      BOOLEANO
		|IDENTIFICADOR
		|IDENTIFICADOR COMPAR dato;

declaracionLibreria:
		INCLUDE LIBRERIA 
		|error
		|linea			
		;

dato:		ENTERO
		|FLOTANTE
		|CARACTER
		|CADENA
;
declaracionVariable:
		TIPODEDATOBOOL IDENTIFICADOR IGUAL BOOLEANO FinCommand {fprintf(archSal,"DeclaracionBooleano\n");}	
		|TIPODEDATOSTRING IDENTIFICADOR IGUAL CADENA FinCommand	{fprintf(archSal,"DeclaracionesCadena\n");}
		|TIPODEDATOENTERO IDENTIFICADOR IGUAL ENTERO FinCommand	{fprintf(archSal,"DeclaracionesEntero\n");}
		|TIPODEDATOFLOTANTE IDENTIFICADOR IGUAL FLOTANTE FinCommand	{fprintf(archSal,"DeclaracionesFlotante\n");}
		|TIPODEDATOCHAR IDENTIFICADOR IGUAL CARACTER FinCommand	{fprintf(archSal,"DeclaracionesCaracter\n");}
		|tipoDeDato IDENTIFICADOR IGUAL IDENTIFICADOR FinCommand	{fprintf(archSal,"Declaracion\n");}
		|tipoDeDato IDENTIFICADOR FinCommand {fprintf(archSal,"Declaracion\n");}
		;
declaracionFuncion:
		tipoDeDato IDENTIFICADOR ParetOP declaracionParametro ParetCL FinCommand {fprintf(archSal,"DeclaracionFuncion \n");}
		|tipoDeDato IDENTIFICADOR ParetOP ParetCL FinCommand	{fprintf(archSal,"DeclaracionFuncion \n");}
		
		
		;
declaracionParametro:
		tipoDeDato IDENTIFICADOR  
		|IDENTIFICADOR
		|tipoDeDato IDENTIFICADOR  COMA declaracionParametro
		|IDENTIFICADOR COMA declaracionParametro
		;
tipoDeDato:
		TIPODEDATOBOOL
		|TIPODEDATOSTRING
		|TIPODEDATOENTERO
		|TIPODEDATOFLOTANTE
		|TIPODEDATOCHAR
		|TIPODEDATOVOID
		;

main:
		tipoDeDato "main" ParetOP declaracionParametro ParetCL "{" programa "}"
		;

linea:
	SALTO_LINEA
	{numLinea++;}
	;

/*error:
	ERROR
	{fprintf(archSal,"--ERROR en la linea %d\n", numLinea);}
	;
*/
%%

void yyerror(char *s) { 
   fprintf(archSal,"--ERROR en linea %d\n", numLinea); 
} 
void main(void) { 
	yyin=fopen("emtrada.txt","r");
	archSal=fopen("salidaSintactica.txt","w");
    	yyparse();  
	fclose(archSal);
} 
