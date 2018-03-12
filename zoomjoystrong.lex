%{
	#include <stdlib.h>
	#include "zoomjoystrong.tab.h"
%}

%option noyywrap

%%

END 				{ yylval.str = strdup(yytext); return END; }
;				{ return END_STATEMENT; }
point				{ yylval.str = strdup(yytext); return POINT; }
line				{ yylval.str = strdup(yytext); return LINE; }
circle				{ yylval.str = strdup(yytext); return CIRCLE; }
rectangle			{ yylval.str = strdup(yytext); return RECTANGLE; }
set_color			{ yylval.str = strdup(yytext); return SET_COLOR; }
[0-9]+				{ yylval.i = atoi(yytext); return INT; }
[0-9]+[.][0-9]+			{ yylval.i = atoi(yytext); return FLOAT; }
[ \t\n]				;
.				{ yylval.str = strdup(yytext); return ERROR; }

%%
