%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "mem.h"
#include "finalproj.tab.h"
%}

%option noyywrap

%%
[ \t] 							
[0-9]+(\.[0-9]+)?   	    	{yylval.num = atof(yytext); return NUMBER;}
"+"   							{return ADD;}
"-"   							{return SUB;}
"*"   							{return MUL;}
"/"   							{return DIV;}
"%"								{return MOD;}
"^"								{return POW;}
"="								{return EQUALS;}
"("								{return L_BRACKET;}
")"								{return R_BRACKET;}
"!"                    	 		{return FACTORIAL;}
("pi")|("PI")					{return PI;}	
("mod")|("MOD")					{return MOD;}
("pow")|("POW")					{return POW;}
("abs")|("ABS")					{return ABS;}
("cos")|("COS")					{return COS;}
("sin")|("SIN")					{return SIN;}
("sqrt")|("SQRT")				{return SQRT;}	
("log2")|("LOG2")				{return LOG2;}
("log10")|("LOG10")				{return LOG10;}
("twd_to_usd")|("TWD_TO_USD")	{return TWD_TO_USD;}
("twd_to_jpy")|("TWD_TO_JPY")	{return TWD_TO_JPY;}
("var")|("VAR")					{return VAR_KEYWORD;}	
[a-zA-Z0-9]+  					{yylval.index = add_variable(yytext); return VARIABLE;}	
[\n]  							{return EOL;}
. 								{yyerror("undefined symbol"); exit(1);} 

%%

