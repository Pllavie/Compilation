#define ID 257
#define NUMBER 258
#define AFFECT 259
#define UNION 260
#define INTER 261
#define DIFF 262
#define COMP 263
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union{
	unsigned int val;
	char nom;
	struct {unsigned int e;char n;} ens;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;
