#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char* yytext;

char* strdup(char*);

void token_handler(void)
{
	/*Open and Read Ignore File*/
	FILE *ignoreFile;
	ignoreFile = fopen("IGNORE", "r");

	/*ERROR CHECK ignoreFile*/
	if(ignoreFile == NULL) {
		printf("ERROR: Cannot open ignore file.\n");
		exit(1);
	}

	/*Allocate 25 words to the ignored list called ignoredWords*/
	char **ignoreWords;
	ignoreWords = (char **)calloc(25, sizeof(char *));

	int ignoreSize = 25;
	int ignoreCount = 0;

	char *ignoreBuffer;
	ignoreBuffer = (char *)calloc(225, sizeof(char));

	while(!feof(ignoreFile) && (fscanf(ignoreFile, "%s", ignoreBuffer) > 0)) {
//		printf("%i\n", ignoreCount);

		if (ignoreCount == ignoreSize) {
			char **newIgnoreWords;
			newIgnoreWords = (char **)calloc(ignoreSize*2, sizeof(char *));
			memcpy(newIgnoreWords, ignoreWords, ignoreSize*sizeof(char*));
			ignoreSize*=2;	
			free(ignoreWords);
			ignoreWords = newIgnoreWords;
		} 

		ignoreWords[ignoreCount] = (char *)strdup(ignoreBuffer);
//		printf("%s\n", ignoreWords[ignoreCount]);
		ignoreCount++;
	}

/*	for (int i=0; i < ignoreCount; i++) {
*		printf("%s\n", ignoreWords[i]);
*	}
*/
	unsigned int t;
	while(( t = yylex()) ) {
		int foundWord = 0;

		for (int j = 0; j < ignoreCount; j++) {
			if (strcmp(yytext, ignoreWords[j])) {
				foundWord = 1;			
				break;
			} else if (strcmp("no words", ignoreWords[j])) {
				foundWord = 2;
				break;
			}
		}

#if defined(NDEBUG)
		if (foundWord == 1) {
			fprintf( stdout, "%03d:/%s/\n", t, yytext );
		} else if (foundWord == 2) {
			exit(1);
		}
#endif
	}

}

