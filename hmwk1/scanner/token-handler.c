#include <stdio.h>

extern char* yytext;

void token_handler(void)
{
	/*Open and Read Ignore File*/
	FILE *ignoreFile;
	ignoreFile = fopen("IGNORE", "r");

	/*ERROR CHECK ignoreFile*/
	if(ignoreFile == NULL) {
		printf("ERROR: Cannot open ignore file.\n");
		exit(-1);
	}

	unsigned int t;
	while(( t = yylex()) ) {
#if defined(NDEBUG)
		fprintf( stdout, "%03d:/%s/\n", t, yytext );
#endif
	} 
}

