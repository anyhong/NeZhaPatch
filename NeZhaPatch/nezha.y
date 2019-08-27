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


/**********************************  解析入口  **********************************/

parsing_entrance:
    | definition_list
    {
        
    }
    ;

/* 递归 */
definition_list: definition
    {
        
    }
    | definition_list definition
    {
        
    }
    ;


definition: class_definition
    {
        
    }
    ;



/**********************************  类解析  **********************************/

/* 类正则 */
class_definition:
    CLASS IDENTIFIER COLON IDENTIFIER LC
    {
        // class ViewController : UIViewController {
    }
    RC
    {
        // }
    }
    | CLASS IDENTIFIER COLON IDENTIFIER protocol_definition LC
    {
        // class ViewController : UIViewController <protocol, protocol1>
    }
    RC
    {
        // }
    }
    | CLASS IDENTIFIER COLON IDENTIFIER LC {
        // class ViewController : UIViewController {
    }
    member_definition_list RC
    {
        // - (void)sequentialStatementExample {
        // }
        // }
    }
    | CLASS IDENTIFIER COLON IDENTIFIER protocol_definition LC {
        // class ViewController : UIViewController <protocol, protocol1>
    }
    member_definition_list RC
    {
        // - (void)sequentialStatementExample {
        // }
        // }
    }
    ;

/**********************************  协议解析  **********************************/

/* 协议正则 */
protocol_definition:
    LT protocol_list GT
    {
        
    }
    ;

/* 递归解析协议列表 */
protocol_list:
    IDENTIFIER
    {
        
    }
    | protocol_list COMMA IDENTIFIER
    {
        
    }
    ;

/***********************  类内部的类方法、实例方法、类属性解析  **********************/

member_definition:
    property_definition
    {
        
    }
    |
    method_definition
    {
        
    }
    ;

/* 递归解析 */
member_definition_list:
    member_definition
    {
        
    }
    | member_definition_list member_definition
    {
        
    }
    ;

/**********************************  属性解析  **********************************/

property_definition:
    PROPERTY LP property_modifier_list RP type_specifier IDENTIFIER SEMICOLON
    {
        
    }
    | PROPERTY LP  RP type_specifier IDENTIFIER SEMICOLON
    {
        
    }
    ;



property_modifier_list: property_modifier
    | property_modifier_list COMMA property_modifier
    {
        
    }
    ;


property_modifier:
    property_rc_modifier
    | property_atomic_modifier
    ;

property_rc_modifier:
    WEAK
    {
        
    }
    | STRONG
    {
        
    }
    | COPY
    {
        
    }
    | ASSIGN_MEM
    {
        
    }
    ;

property_atomic_modifier:
    NONATOMIC
    {
        
    }
    | ATOMIC
    {
        
    }
    ;


/**********************************  方法解析  **********************************/

method_definition:
    instance_method_definition
    {
        
    }
    | class_method_definition
    {
        
    }
    ;



/* 实例方法解析 */
instance_method_definition:
    SUB LP type_specifier RP method_name LC
    {
        
    }
    RC
    {
        
    }
    ;

/* 类方法解析 */
class_method_definition:
    ADD LP type_specifier RP method_name LC
    {
        
    }
    RC
    {
        
    }
    ;

/* 方法名解析 */
method_name:
    method_name_1
    | method_name_2
    ;

method_name_1:
    IDENTIFIER
    {
        
    }
    ;

method_name_2:
    method_name_item
    {
        
    }
    | method_name_2 method_name_item
    {
        
    }
    ;

method_name_item:
    IDENTIFIER COLON LP type_specifier RP IDENTIFIER
    {
        
    }
    ;

type_specifier:
    VOID
    {
        
    }
    | BOOL_
    {
        
    }
    | INT
    {
        
    }
    | U_INT
    {
        
    }
    | DOUBLE
    {
        
    }
    | C_STRING
    {
        
    }
    | ID
    {
        
    }
    | CLASS_
    {
        
    }
    | SEL_
    {
        
    }
    | BLOCK
    {
        
    }
    | POINTER
    {
        
    }
/*
    | C_FUNCTION LT c_type_identier_list GT
    {

    }
 */
    | IDENTIFIER ASTERISK
    {
        
    }
    | STRUCT IDENTIFIER
    {
        
    }
    | IDENTIFIER
    {

    }
    ;
%%




