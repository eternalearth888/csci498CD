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

DIGITS		[0-9]
SPACE       [ \t\n]

%%

{SPACE}+               { }
{DIGITS}+              { return NUMBER; }
[^ \t\n0-9]+           { return NOTNUMBER; }

\/\/.*[\n]   {;} 
\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/ {;}
[ \t\n]+ 

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

	/* token handling code here */
	token_handler();
	return 0;
}

yyerror(char *errmsg) {
	fprintf(stderr, "%s\n", errmsg);
}
