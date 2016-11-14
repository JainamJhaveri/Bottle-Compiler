%{
	#include<stdlib.h>
	#include<stdio.h>	
	#include "y.tab.h"
	int yylex(void);
	void yyerror(char *);	

	struct node* makeLeaf(int val);
	struct node* makeNode(int val, struct node *left, struct node *right);
	void traverse(struct node *ptr);
%}

%token WHILE FOR SWITCH CASE BREAK DEFAULT IF ELSE ELSEIF INT VAR FLOAT AND_AND OR_OR LT LE GT GE EQ_EQ N_EQ COMMA SEMICOLON COLON

%%
// grammar of statements, expr and conditions (Jainam, Digvijay, Karan, Yash)
entry_point: statements;
statements : 		while_main statements
		|	for_main statements
		| 	switch_main statements
		|	if_main statements
		|	statement statements
		|	;

statement: 		VAR '=' expr ';' ;

expr:		beta A_dash;

A_dash : 	'+' expr A_dash
	      |	'-' expr A_dash
	      | '*' expr A_dash
	      | '/' expr A_dash
		|;      

beta :		 	VAR
	      | 	INT
	      | 	FLOAT
      ;
conditions : 		condition
		|	condition AND_AND conditions 
		|	condition OR_OR conditions ;
condition  : VAR LT expr ;

// switch-case (Yash and Digvijay)
switch_main :   SWITCH '(' VAR ')' '{' cases dflt'}';

cases:  	CASE INT ':' statements  cases 
	|  	CASE INT ':' statements BREAK ';' cases 
	|;

dflt: DEFAULT ':' statements   | ;

// while (Jainam, Digvijay, Karan, Yash)
while_main : WHILE '(' conditions ')' '{' statements '}';

// for (Jainam, Digvijay, Karan, Yash)
for_main: FOR '(' statement for_mid ';' for_end ')' '{' statements '}';
for_mid: 	VAR LT expr
		|VAR GT expr
		|VAR LE expr
		|VAR GE expr
		|VAR EQ_EQ expr
		|VAR N_EQ expr ;

		 

for_end: VAR '=' expr ;
/*
exp1:   exp1 '+' exp1
      | exp1 '-' exp1
      | exp1 '*' exp1
      | exp1 '/' exp1
      | '(' expr ')'
      | INT
      | FLOAT
      | VAR
      ;
*/
// if-elseif-else (Dipshil)
if_main:    	IF '(' statement ')' '{' statements '}' 
	| 	IF '(' conditions ')' '{' statements '}' elseif_main ELSE '{' statements '}' ;

elseif_main: ELSEIF '(' conditions ')' '{' statements '}' elseif_main
            | ;

%%


void yyerror(char *s)
{
	fprintf(stderr, "%s\n", s);
}

int main(void)
{
	return ( yyparse() );
}
