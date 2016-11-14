%{

#include <stdio.h>
#include "y.tab.h"

%}

%%
[ \t\n] 		{;}

while 			{return KEY_WHILE; }
for 			{return KEY_FOR; }
switch 			{return KEY_SWITCH;}
case			{return KEY_CASE;}
break			{return KEY_BREAK;}
default 		{return KEY_DEFAULT;}
if			{return KEY_IF;}
else			{return KEY_ELSE;}
elseif			{return KEY_ELSEIF;}

[0-9]+ 			{return INT;}
[a-zA-Z_][_a-zA-Z0-9]* 	{return VAR;}
[0-9]([\.][0-9]+)? 	{return FLOAT;}


"&&" 			{return AND_AND;}
"||" 			{return OR_OR;} 
'<'		 	{return LT;}
'<='		 	{return LE;}
'>'		 	{return GT;}
">="		 	{return GE;}
"==" 			{return EQ_EQ;}
"!=" 			{return N_EQ;}

,			{return COMMA;}
;			{return SEMICOLON;}
:			{return COLON;}

.			{printf("Something else: %s", yytext); return *yytext;}

%%


int yywrap(void) {
	return 1;
}
