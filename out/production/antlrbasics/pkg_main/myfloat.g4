grammar myfloat;

main: FLOAT;
FLOAT: INT ( [\.]INT+ )? ;
INT: [0-9]+ ;

main1: T*;
T: 'hi';