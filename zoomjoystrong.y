%{ 
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int yylex();
	void yyerror(const char* msg);
%}


%error-verbose

%start picture

%union { int i; char* str; }

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token ERROR

%type<i> INT
%type<str> END
%type<str> END_STATEMENT
%type<str> POINT
%type<str> CIRCLE
%type<str> RECTANGLE
%type<str> ERROR
%type<float> FLOAT

%%

zoomjoystrong:	picture end
;

picture: 	command
	|	command picture 
		
;

command:	point 
	|	line 
	|	circle 
	|	rectangle 
	|	set_color 
;

point:		POINT INT INT END_STATEMENT
		{ if (($2) < 0 || ($3) < 0) 
		{ printf("coordinates must be positive"); } 
		else if (($2) > WIDTH || ($3) > HEIGHT) 
		{ printf("coordinates must fit on the screen"); }
		}
;

line:		LINE INT INT INT INT END_STATEMENT
		{ printf("line"); }
		{ if ($2 < 0 || $3 < 0 || $4 < 0 || $5 < 0) 
		{ printf("coordinates must be positive"); } 
		else if ($2 > WIDTH || $3 > HEIGHT || $4 > WIDTH || $5 > HEIGHT) 
		{ printf("coordinates must fit on the screen"); }
		}
;

circle:		CIRCLE INT INT INT END_STATEMENT
		{ printf("circle"); }
		{ if ($2 < 0 || $3 < 0 || $4 < 0) 
		{ printf("coordinates must be positive"); } 
		else if ($2 > WIDTH || $3 > HEIGHT) 
		{ printf("coordinates must fit on the screen"); }
		}
;

rectangle:	RECTANGLE INT INT INT INT END_STATEMENT
		{ if ($2 < 0 || $3 < 0 || $4 < 0 || $5 < 0) 
		{ printf("coordinates must be positive"); } 
		else if ($2 > WIDTH || $3 > HEIGHT || ($4) > WIDTH || ($5) > HEIGHT) 
		{ printf("coordinates must fit on the screen"); }
		}
;

set_color:	SET_COLOR INT INT INT END_STATEMENT
		{ printf("set_color"); }
		{ if ($2 < 0 || $3 < 0 || $4 < 0) 
		{ printf("coordinates must be positive"); } 
		else if ($2 > 255 || $3 > 255 || $4 > 255 )
		{ printf("rgb values must be 255 or less"); }
		}
;

end:		END END_STATEMENT
;

%%

int main(int argc, char** argv) {
	setup();
	yyparse();
	return 0;
}

void yyerror(const char* msg) {
	fprintf(stderr, "ERROR! %s\n", msg);
}
