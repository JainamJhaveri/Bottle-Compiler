grammar test;

// keywords
NEWLINE: [\n ]+ -> skip;
while: 'while';
for: 'for';
switch: 'switch';
case: 'case';
break : 'break';
default : 'default';
if: 'if';
else: 'else';
elseif: 'elseif';

AND_AND : '&&' ;
OR_OR : '||' ;
LT : '<' ;
GT : '>' ;
LE : '<=' ;
GE : '>=' ;
EQUAL_EQUAL : '==' ;
NOT_EQUAL : '!=' ;

// regular expressions
INT: [0-9]+;
VAR: [a-zA-Z_][_a-zA-Z0-9]*;
FLOAT: INT ( [\.] INT+ )? ;

// grammar of statements, expr and conditions (Jainam, Digvijay, Karan, Yash)
statements : (statement | while_main | for_main | switch_main | if_main)*;
statement: VAR '=' expr ';';
expr:   expr '+' expr
      | expr '-' expr
      | expr '*' expr
      | expr '/' expr
      | expr LT expr
      | expr GT expr
      | expr EQUAL_EQUAL expr
      | expr LE expr
      | expr GE expr
      | expr NOT_EQUAL expr
      | '(' expr ')'
      | VAR
      | INT
      | FLOAT
      ;
conditions : condition ( (AND_AND | OR_OR) condition )* ;
condition  : VAR  (LT | GT | LE | GE | EQUAL_EQUAL | NOT_EQUAL) exp1 ;

// switch-case (Yash and Digvijay)
switch_main :   switch '(' VAR ')' '{' cases '}';
cases: cas | cas dflt ;
cas: cas cas | case INT ':' statements | break ';';
dflt: default ':' statements  (break ';'| )  ;

// while (Jainam, Digvijay, Karan, Yash)
while_main : while '(' conditions ')' '{' statements '}';

// for (Jainam, Digvijay, Karan, Yash)
for_main: for '(' statement for_mid ';' for_end ')' '{' statements '}';
for_mid: VAR (LT | GT | LE | GE | EQUAL_EQUAL | NOT_EQUAL) exp1 ;
for_end: VAR '=' exp1 ;
exp1:   exp1 '+' exp1
      | exp1 '-' exp1
      | exp1 '*' exp1
      | exp1 '/' exp1
      | '(' expr ')'
      | INT
      | FLOAT
      | VAR
      ;

// if-elseif-else (Dipshil)
if_main:    if '(' conditions ')' '{' statements '}' (elseif_main else '{' statements '}')? ;

elseif_main: elseif '(' conditions ')' '{' statements '}' elseif_main
            | ;