%{	
	#include <stdio.h>
	#include "tablasimbolos.h"
	extern int error, linea, chars;
	// Target file for the symbol table
	#define TABLE_FILE "tablasimbolos"
	// messages
	#define ERROR 0
	#define WARNING 1
	#define NOTE 2
	// key type for the symbol table
	#define KEY_TYPE -100
	FILE *yyin;
	char *filename;
	int yylex();
	void yyerror();
	int install(const char *lexeme, int type);
	void install_keywords(char* keywords[], int n);
	void install_id(char *name, int type);
	void print_table(table_t table);
	char *strbuild(int option, const char *str1, const char *str2);
	void print_cursor();
	void get_line(char *line);
	#define YYDEBUG 1
%}

%start program
%token MAIN
%token IF ELSE DO WHILE FOR BREAK PRINT RETURN
%token TD_INT TD_FLOAT TD_BOOL
%token STRING ENTERO FLOTANTE BOOLEAN
%token ID
%token MAS_MAS MENOS_MENOS
%token IGUAL_IGUAL MENOR_QUE MAYOR_QUE AND OR NOT

%union {
	char *lexeme;
	int integer;
	float real;
	
}

%type<lexeme> ID
%type<integer> ENTERO l_expr l_factor 
%type<real> FLOTANTE g_expr g_term g_factor 
%type<bool> BOOLEAN

%left '+' '-'
%left '*' '/' //mayor precedencia
%left MAS_MAS MENOS_MENOS
%left IGUAL_IGUAL MENOR_QUE MAYOR_QUE AND OR
%right '='
%right NOT

%glr-parser

%%

//gramáticas
program : MAIN '('')' '{' commands '}' program_end
        | error {yyerror("Error en'main'", ERROR);} ;

program_end :  %empty
            | ID '('')' '{' commands '}' program_end
            | error {yyerror("Error", ERROR);};


commands: command_list;

command_list: '{' command_list '}'
            | command  command_list
            | %empty
            ;

command: cmd ';'
       | stmt
       | error { yyerror("instruccion errónea o ';' faltante", ERROR); }
       ;
	
stmt: if_stmt
    | for_stmt
    | while_stmt 
    | dowhile_stmt
    ;

cmd: PRINT STRING
   | BREAK
   | RETURN
   | attrib
   | declaration
   ;

if_stmt: IF '(' l_expr ')' '{' commands '}' else_stmt;

else_stmt: %empty
         | ELSE '{' commands '}';

for_stmt: FOR '(' ffirst ';' l_expr ';' fthird ')' '{' commands '}';

ffirst: %empty
      | attrib_list;


fthird: %empty
      | cmd ',' fthird
      | cmd;

while_stmt: WHILE '(' l_expr ')' '{' commands '}';

dowhile_stmt: DO '{' commands '}' WHILE '(' l_expr ')' ';';

declaration:
	TD_INT ID {install_id($2, TD_INT);}
	| TD_FLOAT ID {install_id($2, TD_FLOAT);}
	| TD_BOOL ID {install_id($2, TD_BOOL);}
	;

attrib_list: attrib ',' attrib_list
           | attrib
           ;

attrib: i_attrib
	| ID MAS_MAS
		{
		if(get_entry($1))	{set_value($1, get_value($1)+1);}
		else {
			char *str = (char *)strbuild(1, "declaracion de '%s' no encontrada", $1);
			yyerror(str, ERROR);
		     }
		}
	| ID MENOS_MENOS
		{
		if(get_entry($1))	{set_value($1, get_value($1)-1);}
		else {
			char *str = (char *)strbuild(1, "declaracion de '%s' no encontrada", $1);
			yyerror(str, ERROR);
		     }
		}                      
	| ID '=' ID {
	char *str;
	if(get_entry($1) != NULL) {
		// if there's entry gets its value
		if(get_entry($3) != NULL) {
			if(get_type($1) == get_type($3)) {
				set_value($1, get_value($3));
			}
			else {
				str = (char *)strbuild(0,
						(char *)strbuild(1, "tipos de datos incompatibles en '%s' ", $1),
						(char *)strbuild(1, "y '%s'", $3)
						);
			}
		}
		else {
			str = (char *)strbuild(1, "declaracion de '%s' no encontrada", $1);
			yyerror(str, ERROR);
		}
	}
	else {
		str = (char *)strbuild(1, "declaracion de '%s' no encontrada", $1);
		yyerror(str, ERROR);
	}

}
| error { yyerror("formato de atribucion invalido", ERROR); };

i_attrib: ID '=' g_expr {
	if(get_entry($1)) {
		// if they have the same type
		if(get_type($1) == TD_INT) {
			// does the attribution
			set_value($1,(int) $3);
		}
		else if(get_type($1) == TD_FLOAT) {
			// does the attribution
			set_value($1,(float) $3);
		}
		
		else if(get_type($1) == TD_BOOL) {
			// does the attribution
			if($3>0&&$3<1){

			set_value($1,0);}
			else if($3>1&&$3<2)
				{set_value($1,1);}
else {
			yyerror("tipos de datos incompatibles", WARNING);
		}

			}
		
		else {
			yyerror("tipos de datos incompatibles", WARNING);
		}
	}
	else {
		char *str = (char *)strbuild(1, "declaracion de '%s' no encontrada", $1);
		yyerror(str, ERROR);
	}
};
/*
r_attrib: ID '=' r_expr {
	if(get_entry($1)) {
		// if they have the same type
		if(get_type($1) == TD_FLOAT) {
			// does the attribution
			set_value($1, $3);
		}
		else {
			yyerror("tipos de datos incompatibles", WARNING);
		}
	}
	else {
		char *str = (char *)strbuild(1, "declaracion de '%s' no encontrada", $1);
		yyerror(str, ERROR);
	}
};*/


l_expr: l_expr IGUAL_IGUAL l_factor { $$ = $1 == $3; }
      | l_expr AND l_factor { $$ = $1 && $3; }
      | l_expr OR l_factor { $$ = $1 || $3; }
      | l_expr MAYOR_QUE l_factor { $$ = $1 > $3; }
      | l_expr MENOR_QUE l_factor { $$ = $1 < $3; }
      | NOT l_expr { $$ = !$2; }
      | l_factor
      ;

l_factor: '(' l_expr ')' { $$ = $2; }
	| ENTERO { $$ = $1; }
	| FLOTANTE { $$ = $1; }
	| ID {            
		// if there's entry gets its value
		if(get_entry($1)) {
			$$ = (int) get_value($1);
		}
		else {
			char *str = (char *)strbuild(1, "declaracion de '%s' no encontrada", $1);
			yyerror(str, ERROR);
		}
	};

g_expr: g_expr '+' g_term { $$ = $1 + $3; }
      | g_expr '-' g_term { $$ = $1 - $3; } 
      | g_term { $$ = $1; }
      ;

//r_expr: r_expr '+' r_term { $$ = $1 + $3; } 
  //    | r_expr '-' r_term { $$ = $1 - $3; } 
    //  | r_term { $$ = $1; }
      //;

g_term: g_term '*' g_factor { $$ = $1 * $3; } 
      | g_term '/' g_factor { $$ = $1 / $3; } 
      | g_factor { $$ = $1; }
      ;

//r_term: r_term '*' r_factor { $$ = $1 * $3; } 
  //    | r_term '/' r_factor { $$ = $1 / $3; } 
    //  | r_factor { $$ = $1; }
      //;

g_factor: '(' g_expr ')' { $$ = $2; }
        | ENTERO { $$ = $1; }
	| FLOTANTE { $$ = $1; }
        ;

//r_factor: '(' r_expr ')' { $$ = $2; }
  //      | FLOTANTE { $$ = $1; }
    //    ;

%%

int main( int argc, char **argv )
{
	char* keywords[] = {"main", "if", "else", "do", "while", "for", "break", "print",
						"return", "int", "float","bool"};

	// Checks if there are more files to be read 
	++argv, --argc;
	if ( argc > 0 ) {
		filename = strdup(argv[0]);
		yyin = fopen( argv[0], "r" );
	}
	else {
		filename = strdup("stdin");
		yyin = stdin;
	}

	// Initializes the symbol table
	init_table();

	// Install keywords to the first entries of the symbol table
	install_keywords(keywords, 11);

	// Executes the parser
	yyparse();

	if(error==0) {
		printf("Análisis finalizado correctamente\n");
	}
	else {
		printf("Se han encontrado %d errores\n", error);
	}

	// Prints the generated symbol table
	print_table(table);

	return 0;
}

// Inserts entry at the end of the symbol table
// 	-if it's already installed returns 0
int install(const char *lexeme, int type) {
	int success = 1;
	entry_t *e;

	e = (entry_t *)get_entry(lexeme);
	if(e == 0) {
		/* Packs the data in a new entry and puts it
		 * at the head of the table
		 */
		put_entry((entry_t *)create_entry(type, lexeme, 0));
	}
	else {
		// It's already in the table
		success = 0;
	}
	return success;
}

// Inserts all keywords at the beginning of the symbol table
void install_keywords(char* keywords[], int n) {
	int i;
	for(i = 0; i < n; i++) {
		install(keywords[i], KEY_TYPE);
	}
}

// Prints the symbol table on a file
void print_table(table_t table) {
	FILE *f = fopen (TABLE_FILE, "w");
	int i;
	entry_t *cur;
	
	fprintf(f, "TABLA DE SÍMBOLOS\n"
		"%d entries\n\n", table.t_size);

	fprintf(f, "+-------+---------+------------------------------+\n"); 
	fprintf(f, "|   -   |  TIPO   |        TOKEN = VALOR         |\n");
	fprintf(f, "+-------+---------+------------------------------+\n"); 

	for(i = 1, cur = table.t_head;
	    cur != NULL;
	    cur = cur->next, i++) {
		if(cur->type == TD_INT) {
			fprintf(f, "| %-5d | ENTERO  |  %s = %d\n", i, cur->lexeme, (int) cur->value);
		} 
		else if(cur->type == TD_FLOAT) {
			fprintf(f, "| %-5d |FLOTANTE |  %s = %f\n", i, cur->lexeme, (float) cur->value);
		} 
		else if(cur->type == TD_BOOL) {
			fprintf(f, "| %-5d |BOOLEANO |  %s = %f\n", i, cur->lexeme,  cur->value);
		} 
		else if(cur->type == KEY_TYPE) {
			fprintf(f, "| %-5d | PALABRA |  %s\n", i, cur->lexeme);
		}
	}

	fprintf(f, "+-------+---------+------------------------------+\n"); 
}

void yyerror(const char *msg, int type) {
	if(strcmp(msg, "syntax error") == 0) {
		printf("Error Sintactico\n");
	}
	else {
		//Exibe a linha do erro
		switch(type) {
			case ERROR:
				printf("%s:%d:%d: Error: %s\n", filename, linea, chars, msg);
				break;

			case WARNING:
				printf("%s:%d:%d: Advertencia: %s\n", filename, linea, chars, msg);
				break;

			case NOTE:
				printf("%s:%d:%d: Nota: %s\n", filename, linea, chars, msg);
				break;

			default:
				printf("%s:%d:%d: Error: %s\n", filename, linea, chars, msg);
		}

		error++;
		print_cursor();
	}
}

void install_id(char *name, int type) {
	// checks if ID is in symbol table, if it's not then installs it
	if(install(name, type)) {
		// successfully installed it
		//printf("%s was installed.\n", name);
	}
	else {
		int t = get_type(name);
		char *str;
		if(t == type) {
			str = (char *)strbuild(1, "Redeclaracion de '%s'", name);
		}
		else {
			str = (char *)strbuild(1, "Tipos conflictivos para '%s'", name);
		}
		yyerror(str, NOTE);
	}
}

char *strbuild(int option, const char *str1, const char *str2) {
	char *full_str;

	if(option == 1) {
		int size;
		// allocates the size of the resulting string
		size = snprintf(NULL, 0, str1, str2);
		full_str = (char *)malloc(size+1);

		// if there's space then prints into the string
		if(full_str != NULL) {
			snprintf(full_str, size+1, str1, str2);
		}
		// or just returns the first value
		else {
			full_str = (char *)strdup(str1);
		}
	}
	else {
		// concatenates
		full_str = (char *)malloc((strlen(str1) + strlen(str2)) * sizeof(char));
                if(full_str != NULL) {
			strcat(full_str, str1);
			strcat(full_str, str2);
		}
	}

	return full_str;
}

void print_cursor() {
	int i;
	char line[256];

	get_line(line);
	printf("%s", line);

	for(i=0; i<chars-1; i++) {
		if(line[i] == '\t') {
			printf("\t");
		}
		else {
			printf(" ");
		}
	}
	printf("^^\n");
}

void get_line(char *line) {
	int i;
	fpos_t position;

	// saves current position in file
	fgetpos(yyin, &position);

	//fseek(yyin, 0, SEEK_SET);
	rewind(yyin);
	for(i=0; i<linea; i++) {
		fgets(line, 256, yyin);
	}

	// recover position in file
	fsetpos(yyin, &position);
}
