# Définition des cibles particulières
.PHONY: clean, mrproper

# Désactivation des règles implicites
.SUFFIXES:

# Variables
CC = gcc
PROJECT = ensemble
TYPE = .out
BIN = $(PROJECT)$(TYPE)
DOUT =
OBJS = ensemble.o
EXECY = ensembleV2.y
EXECL = ensembleV2.l
LEX = lex
YACC = yacc -d
SRC =
DEPS = ensemble.h
CFLAGS = -W -Wall
LDFLAGS = -ly -lfl

# Création de l'executable Out
all: lex.yy.c y.tab.c $(OBJS)
	$(CC) $^ -o $(BIN) $(LDFLAGS) $(CFLAGS)

#Création du y.tab.c
y.tab.c: $(EXECY)
	$(YACC) $(EXECY) $(CFLAGS)

#Création du lex.yy.c
lex.yy.c: $(EXECL)
	$(LEX) $(EXECL)

#Création des fichiers objets avec les fichiers c renseignés
%.o: %.c $(DEPS)
	$(CC) -c $< -o $@ $(CFLAGS)

# Suppression des fichiers temporaires
clean:
	rm -rf y.tab.c lex.yy.c $(OBJS)