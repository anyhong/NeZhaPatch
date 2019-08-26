%{
    #undef YY_INPUT
    #define YY_INPUT(buf, result, max_size) (result = string_input(buf, max_size))
    #include <Foundation/Foundation.h>
    #include "y.tab.h"
    #define smaller(a, b) ((a) < (b) ? (a) : (b))
    #define larger(a, b) ((a) > (b) ? (a) : (b))
    
    static char const *st_source_string;
    static unsigned long st_current_char_index;
    static unsigned long st_source_len;
    
    #define STRING_ALLOC_SIZE (256)
    static char *st_string_literal_buffer = NULL;
    static int st_string_literal_buffer_size = 0;
    static int st_string_literal_buffer_alloc_size = 0;
    
    void nz_set_source_string(char const *source) {
        st_source_string = source;
        st_current_char_index = 0;
        st_source_len = strlen(source);
    }
    
    void nz_print_initial_log(char *str) {
        NSString *log = [NSString stringWithUTF8String:str];
        NSLog(@"initial: %@\n", log);
    }
    
    void nz_print_comment_log(char *str) {
        NSString *log = [NSString stringWithUTF8String:str];
        NSLog(@"comment: %@\n", log);
    }
    
    void nz_print_comment1_log(char *str) {
        NSLog(@"换行");
    }
    
    void nz_print_ccomment_log(char *str) {
        NSString *log = [NSString stringWithUTF8String:str];
        NSLog(@"ccomment: %@\n", log);
    }
    
    void nz_print_literal_log(char *str) {
        NSString *log = [NSString stringWithUTF8String:str];
        NSLog(@"literal: %@\n", log);
    }
    
    static int string_input(char *buf, int max_size) {
        unsigned long len = st_source_len - st_current_char_index;
        if(len <= 0){
            return 0;
        }
        len = smaller(len, max_size);
        strncpy(buf, &st_source_string[st_current_char_index], len);
        st_current_char_index += len;
        return (int)len;
    }
    
    void mf_open_string_literal_buf(){
        st_string_literal_buffer_size = 0;
    }
    
    void mf_append_string_literal(int letter){
        if (st_string_literal_buffer_size >= st_string_literal_buffer_alloc_size) {
            st_string_literal_buffer_alloc_size +=  STRING_ALLOC_SIZE;
            void *new_pointer = realloc(st_string_literal_buffer, st_string_literal_buffer_alloc_size);
            free(st_string_literal_buffer);
            st_string_literal_buffer = new_pointer;
        }
        st_string_literal_buffer[st_string_literal_buffer_size] = letter;
        st_string_literal_buffer_size++;
    }

    int yywrap(){
        return 1;
    }
    
    int yylex(void);
%}


%start C_COMMENT CC_COMMENT STRING_LITERAL_STATE


%%

<INITIAL>":"    { nz_print_initial_log(yytext); return COLON; }
<INITIAL>"^"    { nz_print_initial_log(yytext); return POWER; }
<INITIAL>","    { nz_print_initial_log(yytext); return COMMA ;}
<INITIAL>";"    { nz_print_initial_log(yytext); return SEMICOLON; }
<INITIAL>"("    { nz_print_initial_log(yytext); return LP; }
<INITIAL>")"    { nz_print_initial_log(yytext); return RP; }
<INITIAL>"["    { nz_print_initial_log(yytext); return LB; }
<INITIAL>"]"    { nz_print_initial_log(yytext); return RB; }
<INITIAL>"{"    { nz_print_initial_log(yytext); return LC; }
<INITIAL>"}"    { nz_print_initial_log(yytext); return RC; }
<INITIAL>"?"    { nz_print_initial_log(yytext); return QUESTION; }
<INITIAL>"&"    { nz_print_initial_log(yytext); return ADDRESS; }
<INITIAL>"@"    { nz_print_initial_log(yytext); return AT; }
<INITIAL>"."    { nz_print_initial_log(yytext); return DOT; }

<INITIAL>"&&"   { nz_print_initial_log(yytext); return AND; }
<INITIAL>"||"   { nz_print_initial_log(yytext); return OR; }
<INITIAL>"!"    { nz_print_initial_log(yytext); return NOT; }

<INITIAL>"=="   { nz_print_initial_log(yytext); return EQ; }
<INITIAL>"!="   { nz_print_initial_log(yytext); return NE; }
<INITIAL>"<"    { nz_print_initial_log(yytext); return LT; }
<INITIAL>"<="   { nz_print_initial_log(yytext); return LE; }
<INITIAL>">"    { nz_print_initial_log(yytext); return GT; }
<INITIAL>">="   { nz_print_initial_log(yytext); return GE; }

<INITIAL>"-"    { nz_print_initial_log(yytext); return SUB; }
<INITIAL>"+"    { nz_print_initial_log(yytext); return ADD; }
<INITIAL>"*"    { nz_print_initial_log(yytext); return ASTERISK; }
<INITIAL>"/"    { nz_print_initial_log(yytext); return DIV; }
<INITIAL>"%"    { nz_print_initial_log(yytext); return MOD; }
<INITIAL>"++"   { nz_print_initial_log(yytext); return INCREMENT; }
<INITIAL>"--"   { nz_print_initial_log(yytext); return DECREMENT; }

<INITIAL>"-="   { nz_print_initial_log(yytext); return SUB_ASSIGN; }
<INITIAL>"+="   { nz_print_initial_log(yytext); return ADD_ASSIGN; }
<INITIAL>"*="   { nz_print_initial_log(yytext); return ASTERISK_ASSIGN; }
<INITIAL>"/="   { nz_print_initial_log(yytext); return DIV_ASSIGN; }
<INITIAL>"%="   { nz_print_initial_log(yytext); return MOD_ASSIGN; }
<INITIAL>"="    { nz_print_initial_log(yytext); return ASSIGN; }

<INITIAL>"/*"   { nz_print_initial_log(yytext);  BEGIN C_COMMENT; }
<INITIAL>"/**"  { nz_print_initial_log(yytext);  BEGIN C_COMMENT; }
<INITIAL>"//"   { nz_print_initial_log(yytext);  BEGIN CC_COMMENT; }
<INITIAL>.      { nz_print_initial_log(yytext); }


<INITIAL>"declare"  { nz_print_initial_log(yytext); return DECLARE; }
<INITIAL>"struct"   { nz_print_initial_log(yytext); return STRUCT; }
<INITIAL>"class"    { nz_print_initial_log(yytext); return CLASS; }


<INITIAL>"if"       { nz_print_initial_log(yytext); return IF; }
<INITIAL>"else"     { nz_print_initial_log(yytext); return ELSE; }
<INITIAL>"for"      { nz_print_initial_log(yytext); return FOR; }
<INITIAL>"in"       { nz_print_initial_log(yytext); return IN; }
<INITIAL>"while"    { nz_print_initial_log(yytext); return WHILE; }
<INITIAL>"do"       { nz_print_initial_log(yytext); return DO; }
<INITIAL>"switch"   { nz_print_initial_log(yytext); return SWITCH; }
<INITIAL>"case"     { nz_print_initial_log(yytext); return CASE; }
<INITIAL>"default"  { nz_print_initial_log(yytext); return DEFAULT; }
<INITIAL>"break"    { nz_print_initial_log(yytext); return BREAK; }
<INITIAL>"continue" { nz_print_initial_log(yytext); return CONTINUE; }
<INITIAL>"return"   { nz_print_initial_log(yytext); return RETURN; }

<INITIAL>"#If"      { nz_print_initial_log(yytext); return ANNOTATION_IF; }

<INITIAL>"@property"    { nz_print_initial_log(yytext); return PROPERTY; }
<INITIAL>"@selector"    { nz_print_initial_log(yytext); return SELECTOR; }
<INITIAL>"weak"         { nz_print_initial_log(yytext); return WEAK; }
<INITIAL>"strong"       { nz_print_initial_log(yytext); return STRONG; }
<INITIAL>"copy"         { nz_print_initial_log(yytext); return COPY; }
<INITIAL>"assign"       { nz_print_initial_log(yytext); return ASSIGN_MEM; }
<INITIAL>"nonatomic"    { nz_print_initial_log(yytext); return NONATOMIC; }
<INITIAL>"atomic"       { nz_print_initial_log(yytext); return ATOMIC; }

<INITIAL>"void"         { nz_print_initial_log(yytext); return VOID; }
<INITIAL>"char"         { nz_print_initial_log(yytext); return CHAR; }
<INITIAL>"BOOL"         { nz_print_initial_log(yytext); return BOOL_; }
<INITIAL>"int"          { nz_print_initial_log(yytext); return INT; }
<INITIAL>"uint"         { nz_print_initial_log(yytext); return U_INT; }
<INITIAL>"double"       { nz_print_initial_log(yytext); return DOUBLE; }
<INITIAL>"CString"      { nz_print_initial_log(yytext); return C_STRING; }
<INITIAL>"id"           { nz_print_initial_log(yytext); return ID; }
<INITIAL>"Class"        { nz_print_initial_log(yytext); return CLASS_; }
<INITIAL>"SEL"          { nz_print_initial_log(yytext); return SEL_; }
<INITIAL>"Block"        { nz_print_initial_log(yytext); return BLOCK; }
<INITIAL>"Pointer"      { nz_print_initial_log(yytext); return POINTER; }
<INITIAL>"CFunction"    { nz_print_initial_log(yytext); return C_FUNCTION; }
<INITIAL>"__weak"       { nz_print_initial_log(yytext); return __WEAK; }
<INITIAL>"__strong"     { nz_print_initial_log(yytext); return __STRONG; }
<INITIAL>"static"       { nz_print_initial_log(yytext); return STATIC; }
<INITIAL>"typedef"      { nz_print_initial_log(yytext); return TYPEDEF; }

<INITIAL>"self"     { nz_print_initial_log(yytext); return SELF; }
<INITIAL>"super"    { nz_print_initial_log(yytext); return SUPER; }
<INITIAL>"nil"      { nz_print_initial_log(yytext); return NIL; }
<INITIAL>"NULL"     { nz_print_initial_log(yytext); return NULL_; }
<INITIAL>"YES"      { nz_print_initial_log(yytext); return YES_; }
<INITIAL>"NO"       { nz_print_initial_log(yytext); return NO_; }

<INITIAL>[A-Za-z_$][A-Za-z_$0-9]* {
    nz_print_initial_log(yytext);
    return IDENTIFIER;
}

<INITIAL>[1-9][0-9]* {
    nz_print_initial_log(yytext);
    return INTETER_LITERAL;
}

<INITIAL>"0"[xX][0-9a-fA-F]+ {
    nz_print_initial_log(yytext);
    return INTETER_LITERAL;
}

<INITIAL>"0"[0-7]+ {
    nz_print_initial_log(yytext);
    return INTETER_LITERAL;
}

<INITIAL>"0" {
    nz_print_initial_log(yytext);
    return INTETER_LITERAL;
}

<INITIAL>[0-9]+\.[0-9]+ {
    nz_print_initial_log(yytext);
    return DOUBLE_LITERAL;
}

<INITIAL>\" {
    nz_print_initial_log(yytext);
    mf_open_string_literal_buf();
    BEGIN STRING_LITERAL_STATE;
}

<INITIAL>[ \t] { nz_print_initial_log(yytext); }
<INITIAL>[\n]  { nz_print_initial_log(yytext); }

<INITIAL>"/*"  { nz_print_initial_log(yytext);  BEGIN C_COMMENT; }
<INITIAL>"/**" { nz_print_initial_log(yytext);  BEGIN C_COMMENT; }
<INITIAL>"//"  { nz_print_initial_log(yytext);  BEGIN CC_COMMENT; }
<INITIAL>.     { nz_print_initial_log(yytext); }


<C_COMMENT>\n       {
    nz_print_comment1_log(yytext);
}

<C_COMMENT>.        {
    nz_print_comment_log(yytext);
}

<C_COMMENT>"*/"     {
    nz_print_comment_log(yytext);
    BEGIN INITIAL;
}

<C_COMMENT><<EOF>>  {
    nz_print_comment_log(yytext);
}

<CC_COMMENT>.       {
    nz_print_ccomment_log(yytext);
}

<CC_COMMENT>\n      {
    nz_print_ccomment_log(yytext);
    BEGIN INITIAL;
}

<CC_COMMENT><<EOF>> {
    nz_print_ccomment_log(yytext);
    BEGIN INITIAL;
}


<STRING_LITERAL_STATE>\" {
    nz_print_literal_log(yytext);
    BEGIN  INITIAL;
    return STRING_LITERAL;
}

<STRING_LITERAL_STATE>. {
    nz_print_literal_log(yytext);
    mf_append_string_literal(yytext[0]);
}

<STRING_LITERAL_STATE>\\\"      { nz_print_literal_log(yytext);  mf_append_string_literal('\"'); }
<STRING_LITERAL_STATE>\\n       { nz_print_literal_log(yytext);  mf_append_string_literal('\n'); }
<STRING_LITERAL_STATE>\\t       { nz_print_literal_log(yytext);  mf_append_string_literal('\t'); }
<STRING_LITERAL_STATE>\\\\      { nz_print_literal_log(yytext);  mf_append_string_literal('\\'); }
<STRING_LITERAL_STATE>[\x81-\x9f\xe0-\xef][\x40-\x7e\x80-\xfc] {
    mf_append_string_literal(yytext[0]);
    mf_append_string_literal(yytext[1]);
    nz_print_literal_log(yytext);
}
 
%%



