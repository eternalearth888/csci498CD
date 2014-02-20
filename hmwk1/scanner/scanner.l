/***************************************************** 
 * flex .l template
 *

<BOF>
{%
C/C++ includes, decls and defs
%}

flex declarations

%%

RE rules for tokenization 

%% 

C/C++ functions

<EOF>
 *
 ******************************************************/

%{
const int NUMBER=1;    /* 0 reserved for EOF! */
const int NOTNUMBER=2;
%}

DIGIT		[0-9]
LETTERS [a-zA-Z_]
SPACE       [ \t\n]

%%

[^ \t\n0-9]+           { return NOTNUMBER; }

\/\/.*[\n]   {;}  /* end of line comments */
\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/ {;} /*block comments*/
[ \t]+	{;}		/* ignore white space */
.	return yytext[0]; /* everything else */

%%

void token_handler();

int main(int argc, char ** argv)
{

	/*skip over program name*/
	if ( argc > 0 ) {
		if (argv[1] && !argv[2]) {
			yyin = fopen ( argv[1], "r");
			token_handler();
		} else if(argv[1] && argv[2]) {
			yyin = fopen ( argv[2], "r");
			token_handler();
		}
	} else {
		yyin = stdin;
	}

	return 0;
}

yyerror(char *errmsg) {
	fprintf(stderr, "%s\n", errmsg);
}
