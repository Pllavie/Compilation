%option nounput
%option noinput
%{
//LAVIE Pierre-louis
//M1 RISE
#include <stdio.h>
#include "y.tab.h"
#include "ensemble.h"
%}

AFFECT ":="
UNION "union"|"UNION"
INTER "inter"|"INTER"
DIFF "diff"|"DIFF"
COMP "comp"|"COMP"
NUMBER [0-9]*
ID [A-Za-z]


%%
[\n]	{ return yytext[0]; }
{UNION} {return UNION;}
{DIFF} {return DIFF;}
{COMP} {return COMP;}
{INTER} {return INTER;}
{ID}	{yylval.nom = yytext[0];return ID;}
{AFFECT}	{return AFFECT;}
{NUMBER}	{yylval.val = conversion_int_ensemble(atoi(yytext));return NUMBER;}
.	{}

%%
