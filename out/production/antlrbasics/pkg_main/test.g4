grammar test;

// keywords
NEWLINE: [\n ]+ -> skip;
key_while: 'while';
key_for: 'for';
key_switch: 'switch';
key_case: 'case';
key_break : 'break';
key_default : 'default';
key_if: 'if';
key_else: 'else';
key_elseif: 'elseif';

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
entry_point: statements;
statements : (statement | while_main | for_main | switch_main | if_main)*;
statement: VAR '=' expr ';' {System.out.println("yo baby");};
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
switch_main :   key_switch '(' VAR ')' '{' cases '}';
cases: cas | cas dflt ;
cas: cas cas | key_case INT ':' statements | key_break ';';
dflt: key_default ':' statements  (key_break ';'| )  ;

// while (Jainam, Digvijay, Karan, Yash)
while_main : key_while '(' conditions ')' '{' statements '}';

// for (Jainam, Digvijay, Karan, Yash)
for_main: key_for '(' statement for_mid ';' for_end ')' '{' statements '}';
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
if_main:    key_if '(' conditions ')' '{' statements '}' (elseif_main key_else '{' statements '}')? ;

elseif_main: key_elseif '(' conditions ')' '{' statements '}' elseif_main
            | ;