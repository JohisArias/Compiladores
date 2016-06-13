%{
	#include <stdlib.h>
	void yyerror(char *);
//	#include "basico.tab.h"
%}

digito [0-9]
entero {digito}+
%%
{entero} 	{return "INTEGER";}
[a-z]+	{return "ID";}
"="	{return "IGUAL";}
.	{yyerror("invalid character");}

%%
int yywrap(void)
{
	return 1;
}


