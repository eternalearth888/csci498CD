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
void readMainMenu();

int main(int argc, char ** argv)
{
	int choice;

	FILE *inputFile;
	char *userFile;

	FILE *outputFile;

	outputFile = fopen("OUTPUT", "a+");

	if (outputFile == NULL) {
		printf("ERROR: Could not create output file.\n");
		exit(-1);
	}


	/*if ignore exists, open it*/
	FILE *ignoreFile;
	ignoreFile = fopen("IGNORE", "r");
	if (ignoreFile != NULL) {
		if (argc <= 1) {

				readMainMenu();
				printf("CHOICE: ");
				scanf("%d", &choice);

				if (choice == 1) {
					printf("TO EXIT: Ctrl+C");
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
				} else if (choice == 3) {
					exit(-1);
				} else {
					puts("not a valid option");
				}

		} else if (argc > 1) {
			printf("Please implement me\n");
		}
	} else {
		printf("You have no ignore file.\n");
		exit(-1);
	}
	token_handler();
	
	fclose(outputFile);
	fclose(inputFile);
	return 0;
}


void readMainMenu() {
	char menuLine;
	FILE *menu;
	menu = fopen("MENU", "r");
	if (menu == NULL) {
		printf("ERROR: Cannot read menu file.\n");
		exit(-1);
	}

	if (menu) {
		while ((menuLine = fgetc(menu)) != EOF) {
			printf("%c", menuLine);
		}
	}
	fclose(menu);
}
