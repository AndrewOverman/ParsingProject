%{
		#include <stdlib.h>
		#include "zoomjoystrong.h"
%}

%%

[END] 												{ return END; }
[;]														{ return END_STATEMENT; }
[POINT || point]							{ return POINT; }
[LINE || line]								{ return LINE; }
[CIRCLE || circle]						{ return CIRCLE; }
[RECTANGLE || rectangle]			{ return RECTANGLE; }
[SET_COLOR || set_color]			{ return SET_COLOR; }
[0-9]+												{ yylval.i = atoi(yytext); return INT; }
[0-9]+[.][0-9]+								{ yylval.i = atoi(yytext); return FLOAT; }
[ \t\n]												;
[0-DEL]+											{return ERROR; }

%%
