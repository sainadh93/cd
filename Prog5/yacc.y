%{
#include <stdio.h>
#include <stdlib.h>
int var_count = 0;
void yyerror(const char *s);
%}
%token INT FLOAT CHAR DOUBLE NUM IDENTIFIER
%%
program : declarations ;
declarations : declaration ';'
             | declarations declaration ';' ;
declaration : type var_list ;
type : INT | FLOAT | CHAR | DOUBLE ;
var_list : var
         | var_list ',' var ;
var : IDENTIFIER
    | IDENTIFIER '[' ']'
    | IDENTIFIER '[' NUM ']' ;
%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
int main() {
    yyparse();
    printf("Total variables declared: %d\n", var_count);
    return 0;
}
