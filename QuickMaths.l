%{
	#include <stdio.h>	
	#include "Ass2.tab.h"

%}

is	"is"
plus	"plus"
minus	"minus"
equals	"what is"
divided	"divided by"
times	"times"
num	[0-9]+	
var	[a-z]
float	[0-9]+\.[0-9]+


%%
{num}		{
			yylval.value = atoi(yytext);	
			return NUM;
		}

{is}		return IS;
{plus}		return PLUS;
{minus}		return MINUS;
{equals}	return EQUALS;
{times}		return TIMES;
{divided}	return DIVIDED;
{var}		{
			yylval.string = strdup(yytext);
			return VAR;
		}
{float}		return FLOAT;

[ \n\r\t]
%%

