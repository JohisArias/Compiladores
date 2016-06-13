%{
/*Programa en lex que convierte cadenas de numeros
  base 10 a base hexadecimal
*/
 	#include<stdlib.h>
 	#include<stdio.h>
	int count = 0;

%}

 dig [0-9]
 num {dig}+

%%
 {num} {int n=atoi(yytext);
         printf("%x",n);
        if(n>9) count++;
 }
%%

main(){
     yylex();
     fprintf(stderr,"Numero de remplazos = %d",count);
     return 0;
}
