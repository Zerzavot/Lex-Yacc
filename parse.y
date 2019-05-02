%{
void yyerror(char*);
#include<stdio.h>  
#include<stdlib.h>
#include"y.tab.h"
int yylex(void);
%}

%token DIGITS START END CHAR IF ELSE WHILE
%left CARP TOPLA BOL CIKAR
%left AND OR LE GE EQ NE
%start start

%%

start: START func END
	;
func:func statement 
	|statement {printf("OK\n");}
	;
	
statement: exp ';'{$$=$1;}
	|CHAR '=' exp ';'
	|while
	|if
	;
exp:
	exp TOPLA term {$$=$1+$3;}
	|exp CIKAR term {$$=$1-$3;}
	|term {$$=$1;}
	;
term:
	term CARP factor{$$=$1*$3;}
	|term BOL factor{$$=$1/$3;}
	|factor{$$=$1;}
	;
factor:
	'(' exp ')' {$$=$2;}
	|CHAR {$$=$1;}
	|DIGITS 
	;
while:
	WHILE '(' conditions ')' '{' statement '}' {if($3==1)$$=$6;}
	;
if:
	IF '(' conditions ')' '{' statement '}' {if($3==1)$$=$6;}
	|IF '(' conditions ')' '{' statement '}' ELSE'{' statement '}' {if($3==1)$$=$6; else $$=$10;}
	;
conditions:
	condition
	|condition AND conditions
	|condition OR conditions
	;
condition:
	CHAR
	|CHAR EQ CHAR
	|CHAR NE CHAR
	|CHAR LE CHAR
	|CHAR GE CHAR
	;

%%

void yyerror(char *s) {
fprintf(stderr, "%s\n", s);
}
int main()
{	yyparse();
	yylex();
     return 0;
}

