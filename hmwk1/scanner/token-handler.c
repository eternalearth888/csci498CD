#include <stdio.h>

extern char* yytext;

void token_handler(void)
{
	unsigned int t;
	while(( t = yylex()) ) {
#if defined(NDEBUG)
		fprintf( stdout, "%03d:/%s/\n", t, yytext );
#endif
	} 
}

