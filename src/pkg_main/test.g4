grammar test;

NEWLINE: [\n ]+ -> skip;
while: 'while';
for: 'for';
switch: 'switch';
case: 'case';
break : 'break';
default : 'default';
BANG : '!' ;
AND_AND : '&&' ;
OR_OR : '||' ;
LT : '<' ;
GT : '>' ;
LE : '<=' ;
GE : '>=' ;
EQUAL_EQUAL : '==' ;
NOT_EQUAL : '!=' ;
INT: [0-9]+;
VAR: [a-zA-Z_][_a-zA-Z0-9]*;
FLOAT: INT ( [\.] INT+ )? ;

statements : (statement | while_main | for_main | switch_main)*;
switch_main :   switch '(' VAR ')' '{' cases '}';
cases: cas | cas dflt ;
cas: cas cas | case INT ':' statements | break ';';
dflt: default ':' statements  (break ';'| )  ;

while_main : while '(' conditions ')' '{' statements '}';
conditions : condition ( ('&&' | '||') condition )* ;
condition  : VAR  (LT | GT | LE | GE | EQUAL_EQUAL | NOT_EQUAL) (VAR | INT | FLOAT) ;


for_main: for '(' statement for_mid ';' for_end ')' '{' statements '}';

for_mid: VAR (LT | GT | LE | GE | EQUAL_EQUAL | NOT_EQUAL) exp1 ;

for_end: VAR '=' exp1 ;
exp1:   exp1 '+' exp1
      | exp1 '-' exp1
      | exp1 '*' exp1
      | exp1 '/' exp1
      | INT
      | FLOAT
      | VAR
      ;

statement: VAR '=' expr ';';
expr:   expr '+' expr
      | expr '-' expr
      | expr '*' expr
      | expr '/' expr
      | expr '<' expr
      | expr '>' expr
      | expr '==' expr
      | expr '<=' expr
      | expr '>=' expr
      | expr '!=' expr
      | '(' expr ')'
      | VAR
      | INT
      | FLOAT
      ;
