%{
	#include <stdlib.h>
	#include "zoomjoystrong.tab.h"

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

[END] 				{ yylval.str = strdup(yytext); return END; }
[;]				{ return END_STATEMENT; }
[point]				{ yylval.str = strdup(yytext); return POINT; }
[line]				{ yylval.str = strdup(yytext); return LINE; }
[circle]			{ yylval.str = strdup(yytext); return CIRCLE; }
[rectangle]			{ yylval.str = strdup(yytext); return RECTANGLE; }
[set_color]			{ yylval.str = strdup(yytext); return SET_COLOR; }
[0-9]+				{ yylval.i = atoi(yytext); return INT; }
[0-9]+[.][0-9]+			{ yylval.i = atoi(yytext); return FLOAT; }
[ \t\n]				;
[0-DEL]+			{ yylval.str = strdup(yytext); return ERROR; }

%%
