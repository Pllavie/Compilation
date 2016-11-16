%{
//LAVIE Pierre-louis
//M1 RISE
#include <stdio.h>
#include <stdlib.h>
#include "ensemble.h"
#include "y.tab.h"
int yylex();
void yyerror (char const *s) {
fprintf (stderr, "%s\n", s);
 }
ensemble tab[1024];
%}



%union{
	unsigned int val;
	char nom;
	struct {unsigned int e;char n;} ens;
}

%token <nom> ID
%token <val> NUMBER

%type <ens> expr
%type <ens> operande
%type <ens> ensemble
%type <ens> listeElements
%type <val> operateurBinaire
%type <val> operateurUnaire


%%
liste:	liste	instruction "\n"
		|
		;

instruction:	ID AFFECT expr {
									tab[$<nom>1]->nom = $<nom>1;
									tab[$<nom>1]->valeur = $<ens.e>3;
								}
			|	ID {
				tab[$<nom>1]->nom = $<nom>1;
				print_ensemble(tab[$<nom>1]);
			}
			;

expr:			operande {
						$<ens.e>$=$<ens.e>1;
						}
			|	operande	operateurBinaire	operande {
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
														defaut:
														perror("Operateur Binaire non reconnu");
														exit(-1);
														}


													}
			|	operateurUnaire		operande {
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

operande:	ID {
			$<ens.e>$=tab[$<nom>1]->valeur;
			$<ens.n>$=$<nom>1;
			}
			|ensemble {$<ens.e>$=$<ens.e>1;}
			;

ensemble:	{ }
			|listeElements {$<ens.e>$=$<ens.e>1;}
			;

listeElements:	NUMBER {$<ens.e>$=my_union($<ens.e>$,$<val>1);}
				| NUMBER , listeElements 	{
											$<ens.e>$=my_union(my_union($<ens.e>$,$<val>1),$<ens.e>2);//Noter $2 et non $3
											}
				;



%%
int main(int argc, char *argv[])
{
	initTable(tab);
    printf("Entrez une chaine :\n");
    yyparse();
    printTable(tab);
    return 0;
}
