%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "func.h"
#include "finalproj.tab.h"

extern double variable_values[100];
extern int variable_set[100];

extern int yylex(void);
extern void yyterminate();
void yyerror(const char *s);
extern FILE* yyin;

%}

%union {
	int index;
	double num;
}

%token<num> NUMBER
%token<num> L_BRACKET R_BRACKET
%token<num> DIV MUL ADD SUB EQUALS
%token<num> PI
%token<num> POW SQRT FACTORIAL MOD
%token<num> LOG2 LOG10
%token<num> ABS
%token<num> TWD_TO_USD 
%token<num> TWD_TO_JPY
%token<num> COS SIN 
%token<num> VAR_KEYWORD
%token<index> VARIABLE
%token<num> EOL

%type<num> program_input
%type<num> line
%type<num> calculation
%type<num> constant
%type<num> expr
%type<num> function
%type<num> log_function
%type<num> trig_function
%type<num> assignment
%type<num> conversion

%left SUB 
%left ADD
%left MUL 
%left DIV 
%left POW SQRT 
%left L_BRACKET R_BRACKET

%%

program_input:
	| program_input line
	;
	
line: 
	EOL 			   {printf("Please enter a calculation:\n");}
	| calculation EOL  {printf("=%.2f\n",$1);}
    ;

calculation:
	expr
	| function
	| assignment
	;
		
constant: PI {$$ = 3.142;}
	;
		
expr:
	SUB expr					{$$ = -$2;}
    | NUMBER            		{$$ = $1;}
	| VARIABLE					{$$ = variable_values[$1];}
	| constant	
	| function
	| expr DIV expr     		{if ($3 == 0) { yyerror("Cannot divide by zero"); exit(1); } else $$ = $1 / $3;}
	| expr MUL expr     		{$$ = $1 * $3;}
	| L_BRACKET expr R_BRACKET  {$$ = $2;}
	| expr ADD expr     		{$$ = $1 + $3;}
	| expr SUB expr   			{$$ = $1 - $3;}
	| expr POW expr     		{$$ = pow($1, $3);}
	| expr MOD expr     		{$$ = modulo($1, $3);}
    ;
		
function: 
	conversion
	| log_function
	| trig_function
	| SQRT expr      		{$$ = sqrt($2);}
	| expr FACTORIAL		{$$ = factorial($1);}
	| ABS expr 				{$$ = abs($2);}
	;

trig_function:
	COS expr  			{$$ = cos($2);}
	| SIN expr 			{$$ = sin($2);}	
	;
	
log_function:
	LOG2 expr 				{$$ = log2($2);}
	| LOG10 expr 			{$$ = log10($2);}
	;
			
	
conversion:
	| expr TWD_TO_USD  { $$ = twd_to_usd($1); }	
	| expr TWD_TO_JPY  { $$ = twd_to_jpy($1); }
	;

assignment: 
	VAR_KEYWORD VARIABLE EQUALS calculation {$$ = set_variable($2, $4);}
	;
%%

int main(int argc, char **argv){
	
	yyin = stdin;
	yyparse();	

}

void yyerror(const char *s){
	printf("ERROR: %s\n", s);
}