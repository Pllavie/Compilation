#include "ensemble.h"

ensemble new_ensemble(char n,unsigned int v)
{
	int i;
	ensemble res = malloc(sizeof(ensemble));
	if (n!='o')
	{
	res->valeur =0b1;
	res->valeur = res->valeur << v;
	}
	else{
		res->valeur =0b0;
	}
	res->nom = n;
	return res;
}

unsigned int conversion_int_ensemble(int x)
{
	if (x<0 || x > 32)
	{
		perror("Error: conversion_int_ensemble prends en paramétre des entiers 0<=x<=32");
    	return(-1);
	}
	unsigned int res = 0b1;
	return 	res << x;
}

unsigned int intersection(unsigned int e1,unsigned int e2)
{
	return e1&e2;
}

unsigned int difference(unsigned int e1,unsigned int e2)//A coder
{
	return intersection(e1,comp(e2));
}

unsigned int comp(unsigned int e)
{
	return ~e;
}

unsigned int my_union(unsigned int e1,unsigned int e2)
{
	return e1|e2;
}

void print_ensemble(ensemble e)
{
	int i=0,b=0;
	printf("\nensemble %c ={",e->nom);
	for(i=0;i<32;i++)
	{
		b = (((e->valeur >> i) & 1) == 1);
		if (b) 
			{printf(" %d,",i);}
	}
	printf("}\n");
}