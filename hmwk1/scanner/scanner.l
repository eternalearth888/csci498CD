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
	int choice;

	FILE *inputFile;
	char *userFile;

	/* file output creation */
	FILE *outputFile;
	outputFile = fopen("ignore_output.txt", "a+");

	if (outputFile == NULL) {
		printf("ERROR: Could not create output file.\n");
		exit(-1);
	}

	/*if ignore exists, open it*/
	if (argc <= 1) {
			printf("Please choose one of the following:\n");
			printf("(1) Simply read from stdin/user input.\n");
			printf("(2) Read from file.\n");
			
			scanf("%d", &choice);

			if (choice == 1) {
					puts("---------------------------");
					puts("Type all you want, then Ctrl+C to exit");
					puts("---------------------------");
				yyin = stdin;
			} else if (choice == 2) {
					printf("%s", "Please input file name: ");
					scanf("%s", userFile);

					inputFile = fopen(userFile, "r");

					if (inputFile == NULL) {
						printf("ERROR: Could not open file or file does not exist.\n");
						exit(-1);
					} else {
						yyin = fopen(userFile, "r");
					}
			} else {
				puts("not a valid option");
			}

	} else if (argc > 1) {
		printf("Please implement me\n");
	}
	token_handler();
	
	fclose(outputFile);
	fclose(inputFile);
	return 0;
}
