%{
	#include <stdio.h>
	#include "y.tab.h"

%}

ID [A-Za-z]([A-Za-z]|[0-9]){0,64}
DELIMITEUR [{}]
AFFECT "="
SEP ","
UNION "union"|"UNION"
INTER "inter"|"INTER"
DIFF "diff"|"DIFF"


%%

[0-9]*	{ yylval.val = atoi(yytext); return NUMBER; }
{DELIMITEUR}|{AFFECT}|{SEP} { return yytext[0]; }
[\n]	{ return yytext[0]; }
.	{ printf("Caractre inconnu: %s", yytext); }

%%
