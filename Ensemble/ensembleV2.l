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
DELIM ("{"|"}")
SEPAR (", ")
ENDLI ("\n")
ESPAC (" ")



%%
{UNION} {return UNION;}
{DIFF} {return DIFF;}
{COMP} {return COMP;}
{INTER} {return INTER;}
{AFFECT}	{return AFFECT;}
{NUMBER}	{yylval.val = conversion_int_ensemble(atoi(yytext));return NUMBER;}
{DELIM}|{ENDLI}|{SEPAR} { return yytext[0]; }
{ESPAC} {;}
{ID}	{yylval.nom = yytext[0];return ID;}

%%
