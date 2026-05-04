%{
#include "prog.tab.h"
#include <string.h>
%}

%%
[a-zA-Z][a-zA-Z0-9]*  { strcpy(yylval.str, yytext); return ID; }
[+\-*/=;()]           { return yytext[0]; }
[ \t\n]               { /* skip spaces and new lines */ }
.                     { return yytext[0]; }
%%

int yywrap(void) {
    return 1;
}