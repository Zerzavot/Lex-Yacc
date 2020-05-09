# Lex-Yacc
Creating an Input Language with the lex and yacc

LEX
In the first part, we included libraries as stdio.h, stdlib.h and functions as y.tab.h, yyerror().
Then, in the second part we defined the phrases that we use in our language, which is used in C Language.
For example, when our language see space, tab or new line it ignores them. Also if it see the some of punctuations as “; = ( ) { }” , it does not change them, they stay exact. We defined the basic operators(+,-,*,/),comparison operators(<=,>=,==,!=), logical operators(&,|), and some special words(while, if, else) in using describe our code.
Our program start with ‘begin’ end  with ‘end’. Our all commands ended by “;”.In program two types exist; “int”, “char”.
Besides, we defined when the program give the error massage.
In last part, we write the functions clearly.

YACC
In the first part, we included libraries as stdio.h, stdlib.h and functions as y.tab.h, yyerror(), yyerror(); again.
In the second part we wrote our code with BNF notation. Firstly, we parsed the “basla” to “fonksiyon”, and “fonksiyon” to ”ifade”. We parsed the “ifade” to “deyim”, “while”, “if”, “for”. We calculated the basic mathmatics operations in “terim” and “deyim”. If you want to compare two char you should use “sart”. If you want use ”&” or “|” operations  you should use “sartlar”.
In last part, like we done in lex we wrote the main and other functions.

THE LEX SOURCE
%{
#include<stdio.h>
#include<stdlib.h>
#include"y.tab.h"
void yyerror(char *);
%}

digits [0-9]+
alf [a-zA-Z]+


%%
begin		return START;
end 		return END;

{digits} 	return (DIGITS);
while		return WHILE;
for		return FOR;
if		return IF;
else		return ELSE;
{alf} 		return CHAR;
\* 		return CARP;
\+ 		return TOPLA;
\/ 		return BOL;
\- 		return CIKAR;

"<="		return LE;
">="		return GE;
"=="		return EQ;
"!="		return NE;

"&" 		return AND;
"|" 		return OR;
";" 		return *yytext;
"="		return *yytext;
"("		return *yytext;
")"		return *yytext;
"{"		return *yytext;
"}"		return *yytext;

[ \t\n] 	;
. 		{yyerror("syntax error");}

%%

int yywrap()
{
		return 1;
}

THE YACC SOURCE
%{
void yyerror(char*);
#include<stdio.h>  
#include<stdlib.h>
#include"y.tab.h"
int yylex(void);
%}

%token DIGITS START END CHAR IF ELSE WHILE FOR
%left CARP TOPLA BOL CIKAR
%left AND OR LE GE EQ NE
%start basla

%%

basla: START fonksiyon END
	;
fonksiyon:fonksiyon ifade
	|ifade {printf("OK\n");}
	;
	
ifade: deyim ';'{$$=$1;}
	|CHAR '=' deyim ';'
	|while
	|if
	|for
	;
deyim:
	deyim TOPLA terim {$$=$1+$3;}
	|deyim CIKAR terim {$$=$1-$3;}
	|terim {$$=$1;}
	;
terim:
	terim CARP faktor{$$=$1*$3;}
	|terim BOL faktor{$$=$1/$3;}
	|faktor{$$=$1;}
	;
faktor:
	'(' deyim ')' {$$=$2;}
	|CHAR {$$=$1;}
	|DIGITS
	;
while:
	WHILE '(' sartlar ')' '{' ifade '}' {if($3==1)$$=$6;}
	;
	
if:
	IF '(' sartlar ')' '{' ifade '}' {if($3==1)$$=$6;}
	|IF '(' sartlar ')' '{' ifade '}' ELSE'{' ifade '}' {if($3==1)$$=$6; else $$=$10;}
	;
sartlar:
	sart
	|sart AND sartlar
	|sart OR sartlar
	;
sart:
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

EXAMPLE


begin
a+b;
4+4;
4+5*3;
i=3;
while(a<=b){a=3;}
if(a<=b){3+4;}
else{a=1;}
if(a&b){a=0;}
