%{
/*
Lavie Pierre-Louis
Wissle Maxime
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define SIZE 1024 //Taille suffisante pour éviter les collision (en fonction du nombre d'identificateur)
#define MAX_IDE 64 //Taille maximum d'une chaîne dans le tableau (valeur arbitraire)

char* tab[SIZE] = {NULL}; //Tableau de hashage

//Fonction permettant la conversion d'une chaîne en code
int keyCode(char* text){
	//Les valeurs de code choisies ici sont arbitraire
	if(strcmp(text, "cin") == 0){
		return 1000;	
	} else if(strcmp(text, "const") == 0){
		return 1001;	
	} else if(strcmp(text, "cout") == 0){
		return 1002;	
	}  else if(strcmp(text, "else") == 0){
		return 1003;	
	} else if(strcmp(text, "if") == 0){
		return 1004;	
	}  else if(strcmp(text, "typedef") == 0){
		return 1005;	
	}  else if(strcmp(text, "while") == 0){
		return 1006;	
	} else if(strcmp(text, "for") == 0){
		return 1007;	
	} else if(strcmp(text, "break") == 0){
		return 1008;	
	}
	return -1;
}

//Fonction de hashage pour la table
unsigned long hash(unsigned char *str)
{
    unsigned long hash = 5381;
    int c;

    while (c = *str++)
        hash = ((hash << 5) + hash) + c; // hash * 33 + c
    return hash % SIZE; //% permet de ne pas dépasser l'indice maximum
}

//Initialise la table des symboles avec les identificateurs prédéfini
void initTable(char** tab){
	int i = 0;
	while(i < SIZE){
		tab[i] = malloc(sizeof(char) * MAX_IDE);
		i++;
	}
	strcpy(tab[hash("char")], "char");
	strcpy(tab[hash("int")], "int");
	strcpy(tab[hash("float")], "float");
	strcpy(tab[hash("void")], "void");
	strcpy(tab[hash("main")], "main");
}

void freeTable(char** tab){
	int i = 0;
	while(i < SIZE){
		free(tab[i]);
		i++;
	}
}

//Affiche la table des symboles (les valeurs existantes uniquement)
void printTable(char** tab){
	int i = 0;
	printf("index    chaine\n");
	while(i < SIZE){
		if(strlen(tab[i]) > 0) printf("%d    %s\n", i, tab[i]);
		i++;
	}
}

%}

IGN ("/*"([^*]|\*+[^*/])*\*+"/")|"\n"|" "|"\t"
PRE "#"[^"\n"]*\n
KWO ("cin"|"const"|"cout"|"else"|"if"|"typedef"|"while"|"for"|"break")
PON ("+"|"-"|"*"|"{"|"}"|"["|"]"|"="|\"|\"|"'"|"'"|"("|")"|"&&"|","|";"|"<"|">"|"<="|">="|"||"|"|")
IDE [A-Za-z]([A-Za-z]|[0-9]){0,64}
IDP ("char"|"int"|"float"|"main"|"void")
CON [-+]?[0-9]([0-9])*
COF [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$
COC (\'[A-Za-z]\')

%%
{IGN}|{IDP}|{PRE} ; //Ne rien faire
{PON} printf("Symbole : \"%s\" Code : %d\n", yytext, *yytext); //Retourne le code ASCII du caractère en question
{KWO} printf("Keyword : \"%s\" Code : %d\n", yytext, keyCode(yytext)); //Affiche un code unique correspondant au mot clé
{CON} printf("Cint : %s\n", yytext); //Plutôt qu'afficher un code, on affiche une chaîne
{COF} printf("Cfloat : %s\n", yytext); //Plutôt qu'afficher un code, on affiche une chaîne
{COC} printf("Ccar : %s\n", yytext); //Plutôt qu'afficher un code, on affiche une chaîne
{IDE} {
	int indice = hash(yytext);
	
	if(strlen(tab[indice]) == 0){
		//On attribue la valeur dans la table de hashage si elle est vide
		strcpy(tab[indice], yytext);	
	}
	else if(strcmp(tab[indice], yytext) == 0){
		;
		//Dans le cas ou notre chaîne est déjà présente dans la table on ne fait rien
	} else if(strcmp(tab[indice], yytext) != 0){
		//Si la chaîne est différente dans la table : collision
		perror("Collision.");
		exit(-1);
	}
}
%%

int main(int argc, char* argv[])
{
	yyin = fopen(argv[1], "r");
	initTable(tab); //Initialisation de la table des symboles
	printf("---ANALYSE---\n");
	yylex();
	printf("\n---TABLE---\n");
	printTable(tab); //Affichage de la table des symboles
	freeTable(tab); //Libération de la mémoire
	fclose(yyin);
	return 0;
}
