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
	++argv, --argc;
	/* read in a file */
	if (argc > 0) {
		yyin = fopen(argv[0], "r");
	} else {
		yyin = stdin;
	}
//	yylex();

	/* token handling code here */
	token_handler();
	return 0;
}

yyerror(char *errmsg) {
	fprintf(stderr, "%s\n", errmsg);
}
