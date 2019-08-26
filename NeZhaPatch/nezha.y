%{
    #import <Foundation/Foundation.h>
    #include "nz_common.h"
    
    int yyerror(char const *str);
    int yylex(void);

%}

%token COLON SEMICOLON COMMA  LP RP LB RB LC RC  QUESTION DOT ASSIGN AT ADDRESS POWER
AND OR NOT EQ NE LT LE GT GE SUB SUB_ASSIGN ADD ADD_ASSIGN ASTERISK_ASSIGN DIV DIV_ASSIGN MOD MOD_ASSIGN INCREMENT DECREMENT
ANNOTATION_IF CLASS STRUCT DECLARE SELECTOR
RETURN IF ELSE FOR IN WHILE DO SWITCH CASE DEFAULT BREAK CONTINUE
PROPERTY WEAK STRONG COPY ASSIGN_MEM NONATOMIC ATOMIC  ASTERISK  VOID
BOOL_ CHAR U_INT INT DOUBLE C_STRING  CLASS_ SEL_ ID POINTER BLOCK __WEAK __STRONG STATIC C_FUNCTION  TYPEDEF

%token <identifier> IDENTIFIER
%token <expression> DOUBLE_LITERAL
%token <expression> STRING_LITERAL
%token <expression> INTETER_LITERAL
%token <expression> SELF
%token <expression> SUPER
%token <expression> NIL
%token <expression> NULL_
%token <expression> YES_
%token <expression> NO_

%%
program:
;
%%




