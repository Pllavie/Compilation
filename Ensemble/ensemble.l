%{
//LAVIE Pierre-louis
//M1 RISE
#include <stdio.h>
#include "y.tab.h"
#include "ensemble.h"
#define SIZE 1024 //Taille suffisante pour éviter les collision (en fonction du nombre d'identificateur)

void initTable(ensemble* tab){
	int i = 0;
	while(i < SIZE){
		tab[i] = new_ensemble('o',0);
		i++;
	}
}

void printTable(ensemble* tab){
	printf("PRINT TABLE");
	int i = 0;
	while(i < SIZE){
		if(tab[i]->nom!='o') print_ensemble(tab[i]);
		i++;
	}
}
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
