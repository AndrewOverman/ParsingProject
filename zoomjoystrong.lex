%{
	#include <stdlib.h>
	#include "zoomjoystrong.h"

	#define END
	#define END_STATEMENT
	#define POINT
	#define LINE
	#define CIRCLE
	#define RECTANGLE
	#define SET_COLOR
	#define INT
	#define FLOAT
	#define ERROR
%}

%option noyywrap

%%

[END] 				{ return END; }
[;]				{ return END_STATEMENT; }
[POINT|point]			{ return POINT; }
[LINE|line]			{ return LINE; }
[CIRCLE|circle]			{ return CIRCLE; }
[RECTANGLE|rectangle]		{ return RECTANGLE; }
[SET_COLOR|set_color]		{ return SET_COLOR; }
[0-9]+				{ return INT; }
[0-9]+[.][0-9]+			{ return FLOAT; }
[ \t\n]				;
[0-DEL]+			{return ERROR; }

%%
