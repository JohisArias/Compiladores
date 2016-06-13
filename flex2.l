%%
%class Lexer
%type Token
Letra = [a-zA-Z_]
Digito = [0-9]
WHITE=[ \t\r\n] //tab, return y enter
%{
    public String lexeme;
%}
%%
<YYINITIAL> 
{
//{finConversion}{ return symbol.FCONVERSION}
 
";"	{ return  symbol(sym.PUNTOCOMA);}


//. {System.out.println("tokenÂ ilegalÂ <" + yytext()+ ">Â Â linea:Â " + (yyline+1) + "Â columna:Â " + (yycolumn+1));}


{WHITE} {
            //Nada
        }

{"int"|"char"|"float"|"double"|"boolean"}   {
                                                lexeme=yytext();
                                                return TIPO_DE_DATO;
                                            }
{Letra}({Letra}|{Digito})* {
                            lexeme=yytext();
                            return VARIABLE;
                           }
{"+" | "-" | "*" | "/" | "="}     {
                    lexeme = yytext ();
                    return OPERADOR;
                }
({Digito}+ | {Letra}+)     {
                                lexeme = yytext();
                                return EXPRESION;
                            }

{"if", "elseif", "else"}    {
                                lexeme=yytext();
                                return CONDICIONAL;
                            }
{"then"}    {
                lexeme=yytext();
                return THEN;
            }

{"("}   {
                                lexeme=yytext();
                                return PARENTESIS_A;
                            }
{")"}   {
                                lexeme=yytext();
                                return PARENTESIS_C;
                            }
{"["}   {
                                lexeme=yytext();
                                return CORCHETE_A;
                            }
{"]"}   {
                                lexeme=yytext();
                                return CORCHETE_C;
                            }
{";"}   {
            lexeme=yytext();
            return PUNTO_Y_COMA;
        }

\n     { // lleva la cuenta de lineas 
         linea_actual ++ ;
       } 
.   {
        return ERROR;//, Simbolo no encontrado;
    }
}//fin YYInitial

//vector
/*
[]tipoDato variable[númeroEntero] < = {exp1,exp2,exp3...} >
donde;
-TipoDato, representa la palabra reservada para algún tipo de dato primitivo
-Variable, el nombre que tendrá el arreglo
-númeroEntero, el tamaño que tendrá el arreglo
- = {exp1, exp2, exp3...}  indica los valores con los cuales serán inicializados cada uno de los elementos del arreglo
*/
