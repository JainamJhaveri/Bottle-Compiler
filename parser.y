%{
    #include<stdlib.h>
    #include<stdio.h>    
    #include<string.h>
    #include "y.tab.h"
    #include "symtab.h"
    int yylex(void);
    void yyerror(char *s);    
    char switch_val[80];
    float temp;
    table symtab[100];
    int varcount=0;
	
%}

%token WHILE FOR SWITCH CASE BREAK DEFAULT IF ELSE ELSEIF INT VAR FLOAT AND_AND OR_OR LT LE GT GE EQ_EQ N_EQ COMMA SEMICOLON COLON
%left '*' '/' '+' '-' 

%%
// grammar of statements, expr and conditions (Jainam, Digvijay, Karan, Dhaval)
entry_point: statements;
statements :         while_main statements
        |    for_main statements
        |     switch_main statements
        |    if_main statements
        |    statement statements
        |    ;

statement:         VAR '=' S ';'  {symtab[$1].value = $3;}  ;

S: expr {$$=$1; printf("\n%d\n",$1);} ;

expr: expr'+'T {$$=$1+$3;}
  |T {$$=$1;};

T:T'*'F {$$=$1*$3;}
  |F {$$=$1;};

F: INT {$$=$1;}
   |VAR {$$ = symtab[$1].value;};



/*

	expr:        beta A_dash	{$$ = $1;}; 

A_dash :     	'+' beta A_dash      {$$ = $$ + $2;}
          |  	'-' beta A_dash      {$$ = $$ - $2;}
          | 	'*' beta A_dash      {$$ = $$ * $2;}
          |	'/' beta A_dash      {$$ = $$ / $2;}
        |;      

beta :          VAR  
          |     INT	{$$ = $1; }
	  |	FLOAT	{$$ = $1;}
      ;

*/

// switch-case (Yash, Digvijay, Dhaval)
switch_main :   SWITCH '(' VAR ')' '{' cases dflt'}' {strcpy(switch_val,$3); printf("%s", switch_val);} ; 

cases:      CASE INT ':' statements  cases 
    |      CASE INT ':' statements BREAK ';' cases 
    |;

dflt: DEFAULT ':' statements   | ;

// while (Jainam, Digvijay, Karan, Yash)
while_main : WHILE '(' for_mid ')' '{' statements '}';

// for (Jainam, Digvijay, Karan, Yash)
for_main: FOR '(' statement for_mid ';' for_end ')' '{' statements '}';

for_mid:       VAR LT expr
        | VAR GT expr
        | VAR LE expr
        | VAR GE expr
        | VAR EQ_EQ expr
        | VAR N_EQ expr 
        | ;

for_end: VAR '=' expr ;
        

// if-elseif-else (Dipshil)
if_main:        IF '(' for_mid ')' '{' statements '}' 
    |     IF '(' for_mid ')' '{' statements '}' elseif_main ELSE '{' statements '}' ;

elseif_main: ELSEIF '(' for_mid ')' '{' statements '}' elseif_main
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
int makeEntry(char *c){
        int i;
        for(i=0;i<varcount;i++)
              if(strcmp(symtab[i].NAME, c)==0)
                return i;
        strcpy(symtab[varcount].NAME,c);
        varcount++;
        return (varcount-1);
}
