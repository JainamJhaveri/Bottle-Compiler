%{

#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

%}

%%

"//".*			{ /* ignore single line comment */ }

while 			{return WHILE; }
for 			{return FOR; }
switch 			{return SWITCH;}
case			{return CASE;}
break			{return BREAK;}
default 		{return DEFAULT;}
if			{return IF;}
else			{return ELSE;}
elseif			{return ELSEIF;}

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


";"			{ return ';'; }
","			{ return ','; }
":"			{ return ':'; }
"="			{ return '='; }
"("			{ return '('; }
")"			{ return ')'; }
"-"			{ return '-'; }
"+"			{ return '+'; }
"*"			{ return '*'; }
"/"			{ return '/'; }

[ \t\n]+ 		{;}

.			{printf("Something else: %s", yytext); return *yytext;}

%%


int yywrap(void) {
	return 1;
}
