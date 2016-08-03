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
%token TIPO_DE_DATO
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
%token FLOAT
%token BOOL
%token CARACTER_ESPECIAL
%token COMPARATIVOS
%token IDENTIFICADOR
%token CHAR 
%token STRING
%token MAS
%token MENOS
%token MULTIPLICACION
%token DIVISION
%token COMA
%token DOS_PUNTOS
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
	|Declaracion_Funcion		{fprintf(archSal,"Declaracion_Funcion");}		
	|declaracionG programa		
	|Declaracion_Funcion programa	{fprintf(archSal,"Declaracion_Funcion");}
	;

declaracionG:
	declaracion_Libreria	{fprintf(archSal,"declaracion_Libreria");}
	|declaracionVariable	{fprintf(archSal,"DeclaracionVariable1");}
	|declaracionFuncion	{fprintf(archSal,"DeclaracionFuncion");}	
	;

declaracion_Libreria:
	INCLUDE LIBRERIA	
	;

declaracionVariable:		
	TIPO_DE_DATO IDENTIFICADOR IGUAL valor PUNTO_Y_COMA			//int x=6;
	|TIPO_DE_DATO IDENTIFICADOR IGUAL IDENTIFICADOR PUNTO_Y_COMA 		//char x = a;
	|TIPO_DE_DATO IDENTIFICADOR PUNTO_Y_COMA 				//float f;		
	|declaracionVector PUNTO_Y_COMA //string  adf [5];
	;		
	
declaracionVector:
	TIPO_DE_DATO IDENTIFICADOR COR_ABIERTO ENTEROPOSITIVO COR_CERRADO //string  adf [5]
	;

declaracionFuncion:
	TIPO_DE_DATO IDENTIFICADOR PAR_ABIERTO parametroFuncion PAR_CERRADO PUNTO_Y_COMA
	|TIPO_DE_DATO IDENTIFICADOR PAR_ABIERTO PAR_CERRADO PUNTO_Y_COMA
	|VOID IDENTIFICADOR PAR_ABIERTO parametroFuncion PAR_CERRADO PUNTO_Y_COMA
	|VOID IDENTIFICADOR PAR_ABIERTO PAR_CERRADO PUNTO_Y_COMA
	;

Declaracion_Funcion:
	TIPO_DE_DATO IDENTIFICADOR PAR_ABIERTO parametroFuncion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA
	|TIPO_DE_DATO IDENTIFICADOR PAR_ABIERTO PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA	
	|VOID IDENTIFICADOR PAR_ABIERTO parametroFuncion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA  	
	|VOID IDENTIFICADOR PAR_ABIERTO PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA			
	;

parametroFuncion:
	TIPO_DE_DATO IDENTIFICADOR				//int x
	|TIPO_DE_DATO IDENTIFICADOR COMA parametroFuncion	//int x, string y,...
	;

bloque:
	llamadaIf			
	|llamadaWhile			
	|llamadaDoWhile			
	|llamada_a_Funcion			
	|declaracionVariable 		{fprintf(archSal,"declaracion_Variable");}	
	|asig_variable					
	|llamadaIf bloque			
	|llamadaWhile bloque			
	|llamadaDoWhile	bloque		
	|llamada_a_Funcion bloque		
	|declaracionVariable bloque			
	|asig_variable bloque			
	;

llamadaIf:
	IF PAR_ABIERTO condicion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA						{fprintf(archSal,"declaracion_If");}	
	|IF PAR_ABIERTO condicion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA ELSE LLAV_ABIERTA bloque LLAV_CERRADA 	{fprintf(archSal,"declaracion_If");}		
	;

llamadaWhile:
	WHILE PAR_ABIERTO condicion PAR_CERRADO LLAV_ABIERTA bloque LLAV_CERRADA	{fprintf(archSal,"declaracion_While");}				
	;

llamadaDoWhile:
	DO LLAV_ABIERTA bloque LLAV_CERRADA WHILE PAR_ABIERTO condicion PAR_CERRADO PUNTO_Y_COMA	{fprintf(archSal,"declaracion_Do_While");}		
	;
llamada_a_Funcion:
	IDENTIFICADOR PAR_ABIERTO argumentos PAR_CERRADO PUNTO_Y_COMA		{fprintf(archSal,"llamada_a_Funcion");}	
	|IDENTIFICADOR PAR_ABIERTO PAR_CERRADO PUNTO_Y_COMA			{fprintf(archSal,"llamada_a_Funcion");}	
	;

argumentos:
	variable_opcional					
	|variable_opcional COMA argumentos		
	;

condicion:      
	BOOL				
	|variable_opcional COMPARATIVOS variable_opcional			
	|llamada_a_Funcion				
	|llamada_a_Funcion COMPARATIVOS variable_opcional		
	|llamada_a_Funcion COMPARATIVOS llamada_a_Funcion	
	;

valor:		
	numero		
	|cadena 			
	;

numero:
	ENTEROPOSITIVO	
	|ENTERONEGATIVO
	|FLOAT
	;

cadena:
	|CHAR 
	|STRING
	;

operacion:
	MAS
	|MENOS	
	|MULTIPLICACION
	|DIVISION
	;


asig_variable:
	IDENTIFICADOR IGUAL otra_opcional	{fprintf(archSal1,"asignacion_Variable"); }
	;

variable_opcional:
	IDENTIFICADOR 	{fprintf(archSal1,"%s \t|\n",yytext); }
	|valor		
	;

otra_opcional:
	variable_opcional PUNTO_Y_COMA		
	|variable_opcional operacion otra_opcional	
	;

%%
	void yyerror(char *s)
	{ 
   		fprintf(stderr, "Error en la Linea: %d\n",linea); //imprime en consola el número de línea de error
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
		fprintf(archSal1,"+---------------+---------------+");
		//
	    	yyparse();  //llamada al analizador sintáctico
		fclose(archSal);
	} 
