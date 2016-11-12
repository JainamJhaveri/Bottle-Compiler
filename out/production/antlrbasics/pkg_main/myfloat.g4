grammar myfloat;

main: FLOAT;
FLOAT: INT ( [\.]INT+ )? ;
INT: [0-9]+ ;