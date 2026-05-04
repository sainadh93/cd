%{
#include "y.tab.h"
%}
%%
"int"       { return INT; }
"float"     { return FLOAT; }
"char"      { return CHAR; }
"double"    { return DOUBLE; }
[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFIER; }
[0-9]+      { return NUM; }
"["         { return '['; }
"]"         { return ']'; }
","         { return ','; }
";"         { return ';'; }
[ \t\n]     ;
#           { return 0; }
