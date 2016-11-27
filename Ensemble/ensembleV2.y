%{
//LAVIE Pierre-louis
//M1 RISE
#include <stdio.h>
#include <stdlib.h>
#include "ensemble.h"
extern int yylex();
 void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
#define SIZE 1024
ensemble tab[SIZE];

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


%union{
	unsigned int val;
	char nom;
	struct {unsigned int e;char n;} ens;
}

%token <val>UNION INTER DIFF COMP AFFECT
%token <nom> ID
%token <val> NUMBER

%type <ens> expr operande ensemble listeElements
%type <val> operateurBinaire operateurUnaire

%%
liste:	liste instruction '\n'
		|
		

instruction:	ID AFFECT expr
				{
				tab[(int)$<nom>1]->nom = $<nom>1;
				tab[(int)$<nom>1]->valeur = $<ens.e>3;
				}
			|	ID 
			{
			tab[(int)$<nom>1]->nom = $<nom>1;
			print_ensemble(tab[(int)$<nom>1]);
			}
			;

expr:		operande 
				{$<ens.e>$=$<ens.e>1;}
			|	operande	operateurBinaire	operande 
				{
				int op = $<val>2;
				switch(op) {
					case UNION :
						$<ens.e>$=my_union($<ens.e>1,$<ens.e>3);
						break;
					case INTER :
						$<ens.e>$=intersection($<ens.e>1,$<ens.e>3);
						break;
					case DIFF :
						$<ens.e>$=difference($<ens.e>1,$<ens.e>3);
						break;
					default:
						perror("Operateur Binaire non reconnu");
						exit(-1);
							}
				}
			|	operateurUnaire		operande 
				{
					if($<val>1==COMP)
					{
					$<ens.e>$=comp($<ens.e>2);
					}
				}
			;

operateurBinaire:	UNION {$<val>$=UNION;}
					|INTER {$<val>$=INTER;}
					|DIFF {$<val>$=DIFF;}
					;

operateurUnaire:	COMP {$<val>$=COMP;}
					;

operande:	ID
			{
			$<ens.e>$=tab[(int)yylval.nom]->valeur;
			$<ens.n>$=yylval.nom;
			}
			|ensemble {$<ens.e>$=$<ens.e>1;}
			;

ensemble:	'{' '}' { ;}
			|'{' listeElements '}' {$<ens.e>$=$<ens.e>2;}
			;

listeElements:	NUMBER 
				{
				$<ens.e>$=my_union($<ens.e>$,yylval.val);
				}
				| NUMBER ',' listeElements
				{
			$<ens.e>$=my_union(my_union($<ens.e>$,yylval.val),$<ens.e>3);
				}
				;

%%
int main()
{
	initTable(tab);
    printf("Entrez une chaine :");
    yyparse();
    printTable(tab);
    return 0;
}
