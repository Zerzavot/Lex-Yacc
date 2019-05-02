%{
#include<stdio.h> 
#include<stdlib.h>
#include"y.tab.h"
//#include"lex.yy.c"
void yyerror(char *);
%}

digits [0-9]+
alf [a-zA-Z]+


%%
begin		return START;
end 		return END;

{digits} 	return (DIGITS);
while		return WHILE;
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

%%

int yywrap()
{
return 1;
}
//. 		{yyerror("syntax error");}


