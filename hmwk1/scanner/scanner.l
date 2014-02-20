/***************************************************** 
 * flex .l template
 *

<BOF>
{%
C/C+dd+ includes, decls and defs
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
[ \t\n]+	{;}		/* ignore white space */
.	return yytext[0]; /* everything else */

%%

void token_handler();

int main(int argc, char ** argv)
{
	token_handler();
	
	return 0;
}
