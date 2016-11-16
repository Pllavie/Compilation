#if !defined( ENSEMBLE_H )
#define ENSEMBLE_H
//LAVIE Pierre-louis
//M1 RISE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct {
   char nom;//Le char 'o' correspond à l'ensemble vide
   unsigned int valeur;
} *ensemble;

ensemble new_ensemble(char,unsigned int);

unsigned int conversion_int_ensemble(int);//Converit un entier < 32 en une représentation ensembliste 3 -> 1000

unsigned int intersection(unsigned int,unsigned int);

unsigned int difference(unsigned int,unsigned int);

unsigned int comp(unsigned int);

unsigned int my_union(unsigned int,unsigned int);

void print_ensemble(ensemble);
#endif



