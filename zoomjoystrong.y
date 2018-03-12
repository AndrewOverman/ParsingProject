%{ 
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int yylex();
	void yyerror(const char* msg);
%}


%error-verbose
%start picture
%union {int i; char* str;}

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
/* %type <str> STATEMENT 		/* any string with END */ 
/* %type <str> FULL_STATEMENT 	/* STATEMENT followed by ';' */
/* %type <str> LINE 		/* LINE x y u v  */
/* %type <str> POINT		/* POINT x y */
/* %type <str> CIRCLE		/* CIRCLE x y r */
/* %type <str> RECTANGLE		/* RECTANGLE x y w h */
/* %type <i> SET_COLOR		/* SET_COLOR r g b */
/* %type <float> */
/* %type <str> ERROR		/* any string that isn't above */

%%
picture: 	command
	|	command picture
;

command:	point END_STATEMENT
	|	line END_STATEMENT
	|	circle END_STATEMENT
	|	rectangle END_STATEMENT
	|	set_color END_STATEMENT
;

point:		POINT INT INT
		{ if (($2) < 0 || ($3) < 0) 
		{ printf("coordinates must be positive"); } 
		else if (($2) > WIDTH || ($3) > HEIGHT) 
		{ printf("coordinates must fit on the screen"); }
		}
;

line:		LINE INT INT INT INT
		{ if ($2 < 0 || $3 < 0 || $4 < 0 || $5 < 0) 
		{ printf("coordinates must be positive"); } 
		else if ($2 > WIDTH || $3 > HEIGHT || $4 > WIDTH || $5 > HEIGHT) 
		{ printf("coordinates must fit on the screen"); }
		}
;
circle:		CIRCLE INT INT INT
		{ if ($2 < 0 || $3 < 0 || $4 < 0) 
		{ printf("coordinates must be positive"); } 
		else if ($2 > WIDTH || $3 > HEIGHT) 
		{ printf("coordinates must fit on the screen"); }
		}
;

rectangle:	RECTANGLE INT INT INT INT 
		{ if ($2 < 0 || $3 < 0 || $4 < 0 || $5 < 0) 
		{ printf("coordinates must be positive"); } 
		else if ($2 > WIDTH || $3 > HEIGHT || ($4 + $2) > WIDTH || ($5 + $3) > HEIGHT) 
		{ printf("coordinates must fit on the screen"); }
		}
;

set_color:	SET_COLOR INT INT INT
		{ if ($2 < 0 || $3 < 0 || $4 < 0) 
		{ printf("coordinates must be positive"); } 
		else if ($2 > 255 || $3 > 255 || $4 > 255 )
		{ printf("rgb values must be 255 or less"); }
		}
;

%%

int main(int argc, char** argv) {
	yyparse();
	return 0;
}

void yyerror(const char* msg) {
	fprintf(stderr, "ERROR! %s\n", msg);
}
