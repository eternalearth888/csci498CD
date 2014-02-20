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

%%

void token_handler();

main()
{
	/* token handling code here */
	token_handler();
	return 0;
}

