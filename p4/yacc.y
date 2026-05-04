%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

int tempCount = 1;
int quadIndex = 0;

struct Quad {
    char op[10];
    char arg1[20];
    char arg2[20];
    char result[20];
} quad[50];

char* newTemp() {
    char *temp = (char*)malloc(10);
    sprintf(temp, "t%d", tempCount++);
    return temp;
}

void addQuad(char *op, char *arg1, char *arg2, char *result) {
    strcpy(quad[quadIndex].op, op);
    strcpy(quad[quadIndex].arg1, arg1);
    strcpy(quad[quadIndex].arg2, arg2);
    strcpy(quad[quadIndex].result, result);
    quadIndex++;
}
%}

%union {
    char str[20];
}

%token <str> ID
%type <str> E

%left '+' '-'
%left '*' '/'

%%
S : ID '=' E ';' {
        printf("\nThree Address Code:\n");
        for(int i = 0; i < quadIndex; i++) {
            printf("%s = %s %s %s\n", quad[i].result, quad[i].arg1, quad[i].op, quad[i].arg2);
        }
        printf("%s = %s\n", $1, $3);

        printf("\nQuadruples:\n");
        printf("Op\tArg1\tArg2\tResult\n");
        for(int i = 0; i < quadIndex; i++) {
            printf("%s\t%s\t%s\t%s\n", quad[i].op, quad[i].arg1, quad[i].arg2, quad[i].result);
        }
        printf("=\t%s\t-\t%s\n", $3, $1);

        printf("\nTriples:\n");
        printf("Index\tOp\tArg1\tArg2\n");
        for(int i = 0; i < quadIndex; i++) {
            printf("%d\t%s\t%s\t%s\n", i, quad[i].op, quad[i].arg1, quad[i].arg2);
        }
        printf("%d\t=\t%s\t%s\n", quadIndex, $1, $3);
    }
  ;

E : E '+' E {
        char *temp = newTemp();
        addQuad("+", $1, $3, temp);
        strcpy($$, temp);
    }
  | E '-' E {
        char *temp = newTemp();
        addQuad("-", $1, $3, temp);
        strcpy($$, temp);
    }
  | E '*' E {
        char *temp = newTemp();
        addQuad("*", $1, $3, temp);
        strcpy($$, temp);
    }
  | E '/' E {
        char *temp = newTemp();
        addQuad("/", $1, $3, temp);
        strcpy($$, temp);
    }
  | '(' E ')' {
        strcpy($$, $2);
    }
  | ID {
        strcpy($$, $1);
    }
  ;
%%

int main(void) {
    printf("Enter assignment expression, example: a=b+c*d;\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Invalid expression\n");
}