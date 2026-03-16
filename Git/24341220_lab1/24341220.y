%{

#include "symbol_info.h"

#define YYSTYPE symbol_info*

int yyparse(void);
int yylex(void);
extern FILE *yyin;

ofstream outlog;

int lines;

void yyerror(const char *s) {
    outlog << "Error: " << s << " at line " << lines << endl;
}
%}

%token INT FLOAT VOID
%token IF ELSE FOR WHILE DO BREAK RETURN SWITCH CASE DEFAULT CONTINUE GOTO PRINTLN
%token SEMICOLON COMMA COLON
%token LCURL RCURL LPAREN RPAREN LTHIRD RTHIRD
%token ID CONST_INT CONST_FLOAT
%token ADDOP MULOP INCOP DECOP RELOP ASSIGNOP LOGICOP NOT

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%

start : program {
    outlog << "At line no: " << lines << " start : program" << endl << endl;
    outlog << $1->gettext() << endl << endl;
}
;

program : program unit {
    $$ = new symbol_info("", "program");
    $$->settext($1->gettext() + "\n" + $2->gettext());
    outlog << "At line no: " << lines << " program : program unit" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| unit {
    $$ = $1;
    outlog << "At line no: " << lines << " program : unit" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

unit : var_declaration {
    $$ = $1;
    outlog << "At line no: " << lines << " unit : var_declaration" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| func_definition {
    $$ = $1;
    outlog << "At line no: " << lines << " unit : func_definition" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement {
    $$ = new symbol_info("", "func_def");
    $$->settext($1->gettext() + " " + $2->getname() + "(" + $4->gettext() + ")\n" + $6->gettext());
    outlog << "At line no: " << lines << " func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| type_specifier ID LPAREN RPAREN compound_statement {
    $$ = new symbol_info("", "func_def");
    $$->settext($1->gettext() + " " + $2->getname() + "()\n" + $5->gettext());
    outlog << "At line no: " << lines << " func_definition : type_specifier ID LPAREN RPAREN compound_statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

parameter_list : parameter_list COMMA type_specifier ID {
    $$ = new symbol_info("", "param_list");
    $$->settext($1->gettext() + ", " + $3->gettext() + " " + $4->getname());
    outlog << "At line no: " << lines << " parameter_list : parameter_list COMMA type_specifier ID" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| parameter_list COMMA type_specifier {
    $$ = new symbol_info("", "param_list");
    $$->settext($1->gettext() + ", " + $3->gettext());
    outlog << "At line no: " << lines << " parameter_list : parameter_list COMMA type_specifier" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| type_specifier ID {
    $$ = new symbol_info("", "param_list");
    $$->settext($1->gettext() + " " + $2->getname());
    outlog << "At line no: " << lines << " parameter_list : type_specifier ID" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| type_specifier {
    $$ = $1;
    outlog << "At line no: " << lines << " parameter_list : type_specifier" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

compound_statement : LCURL statements RCURL {
    $$ = new symbol_info("", "compound");
    $$->settext("{\n" + $2->gettext() + "\n}");
    outlog << "At line no: " << lines << " compound_statement : LCURL statements RCURL" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| LCURL RCURL {
    $$ = new symbol_info("", "compound");
    $$->settext("{}");
    outlog << "At line no: " << lines << " compound_statement : LCURL RCURL" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

var_declaration : type_specifier declaration_list SEMICOLON {
    $$ = new symbol_info("", "var_decl");
    $$->settext($1->gettext() + " " + $2->gettext() + ";");
    outlog << "At line no: " << lines << " var_declaration : type_specifier declaration_list SEMICOLON" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

type_specifier : INT {
    $$ = new symbol_info("int", "type");
    outlog << "At line no: " << lines << " type_specifier : INT" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| FLOAT {
    $$ = new symbol_info("float", "type");
    outlog << "At line no: " << lines << " type_specifier : FLOAT" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| VOID {
    $$ = new symbol_info("void", "type");
    outlog << "At line no: " << lines << " type_specifier : VOID" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

declaration_list : declaration_list COMMA ID {
    $$ = new symbol_info("", "decl_list");
    $$->settext($1->gettext() + ", " + $3->getname());
    outlog << "At line no: " << lines << " declaration_list : declaration_list COMMA ID" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD {
    $$ = new symbol_info("", "decl_list");
    $$->settext($1->gettext() + ", " + $3->getname() + "[" + $5->getname() + "]");
    outlog << "At line no: " << lines << " declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| ID {
    $$ = $1;
    outlog << "At line no: " << lines << " declaration_list : ID" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| ID LTHIRD CONST_INT RTHIRD {
    $$ = new symbol_info("", "decl_list");
    $$->settext($1->getname() + "[" + $3->getname() + "]");
    outlog << "At line no: " << lines << " de claration_list : ID LTHIRD CONST_INT RTHIRD" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

statements : statement {
    $$ = $1;
    outlog << "At line no: " << lines << " statements : statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| statements statement {
    $$ = new symbol_info("", "statements");
    $$->settext($1->gettext() + "\n" + $2->gettext());
    outlog << "At line no: " << lines << " statements : statements statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

statement : var_declaration {
    $$ = $1;
    outlog << "At line no: " << lines << " statement : var_declaration" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| expression_statement {
    $$ = $1;
    outlog << "At line no: " << lines << " statement : expression_statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| compound_statement {
    $$ = $1;
    outlog << "At line no: " << lines << " statement : compound_statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| FOR LPAREN expression_statement expression_statement expression RPAREN statement {
    $$ = new symbol_info("", "for_stmt");
    $$->settext("for(" + $3->gettext() + " " + $4->gettext() + " " + $5->gettext() + ")\n" + $7->gettext());
    outlog << "At line no: " << lines << " statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
    $$ = new symbol_info("", "if_stmt");
    $$->settext("if(" + $3->gettext() + ")\n" + $5->gettext());
    outlog << "At line no: " << lines << " statement : IF LPAREN expression RPAREN statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| IF LPAREN expression RPAREN statement ELSE statement {
    $$ = new symbol_info("", "if_else_stmt");
    $$->settext("if(" + $3->gettext() + ")\n" + $5->gettext() + "\nelse\n" + $7->gettext());
    outlog << "At line no: " << lines << " statement : IF LPAREN expression RPAREN statement ELSE statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| WHILE LPAREN expression RPAREN statement {
    $$ = new symbol_info("", "while_stmt");
    $$->settext("while(" + $3->gettext() + ")\n" + $5->gettext());
    outlog << "At line no: " << lines << " statement : WHILE LPAREN expression RPAREN statement" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| PRINTLN LPAREN ID RPAREN SEMICOLON {
    $$ = new symbol_info("", "println_stmt");
    $$->settext("println(" + $3->getname() + ");");
    outlog << "At line no: " << lines << " statement : PRINTLN LPAREN ID RPAREN SEMICOLON" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| RETURN expression SEMICOLON {
    $$ = new symbol_info("", "return_stmt");
    $$->settext("return " + $2->gettext() + ";");
    outlog << "At line no: " << lines << " statement : RETURN expression SEMICOLON" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

expression_statement : SEMICOLON {
    $$ = new symbol_info(";", "expr_stmt");
    outlog << "At line no: " << lines << " expression_statement : SEMICOLON" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| expression SEMICOLON {
    $$ = new symbol_info("", "expr_stmt");
    $$->settext($1->gettext() + ";");
    outlog << "At line no: " << lines << " expression_statement : expression SEMICOLON" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

variable : ID {
    $$ = $1;
    outlog << "At line no: " << lines << " variable : ID" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| ID LTHIRD expression RTHIRD {
    $$ = new symbol_info("", "var_array");
    $$->settext($1->getname() + "[" + $3->gettext() + "]");
    outlog << "At line no: " << lines << " variable : ID LTHIRD expression RTHIRD" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

expression : logic_expression {
    $$ = $1;
    outlog << "At line no: " << lines << " expression : logic_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| variable ASSIGNOP logic_expression {
    $$ = new symbol_info("", "assign_expr");
    $$->settext($1->gettext() + "=" + $3->gettext());
    outlog << "At line no: " << lines << " expression : variable ASSIGNOP logic_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

logic_expression : rel_expression {
    $$ = $1;
    outlog << "At line no: " << lines << " logic_expression : rel_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| rel_expression LOGICOP rel_expression {
    $$ = new symbol_info("", "logic_expr");
    $$->settext($1->gettext() + $2->getname() + $3->gettext());
    outlog << "At line no: " << lines << " logic_expression : rel_expression LOGICOP rel_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

rel_expression : simple_expression {
    $$ = $1;
    outlog << "At line no: " << lines << " rel_expression : simple_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| simple_expression RELOP simple_expression {
    $$ = new symbol_info("", "rel_expr");
    $$->settext($1->gettext() + $2->getname() + $3->gettext());
    outlog << "At line no: " << lines << " rel_expression : simple_expression RELOP simple_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

simple_expression : term {
    $$ = $1;
    outlog << "At line no: " << lines << " simple_expression : term" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| simple_expression ADDOP term {
    $$ = new symbol_info("", "simple_expr");
    $$->settext($1->gettext() + $2->getname() + $3->gettext());
    outlog << "At line no: " << lines << " simple_expression : simple_expression ADDOP term" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

term : unary_expression {
    $$ = $1;
    outlog << "At line no: " << lines << " term : unary_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| term MULOP unary_expression {
    $$ = new symbol_info("", "term");
    $$->settext($1->gettext() + $2->getname() + $3->gettext());
    outlog << "At line no: " << lines << " term : term MULOP unary_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

unary_expression : ADDOP unary_expression {
    $$ = new symbol_info("", "unary_expr");
    $$->settext($1->getname() + $2->gettext());
    outlog << "At line no: " << lines << " unary_expression : ADDOP unary_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| NOT unary_expression {
    $$ = new symbol_info("", "unary_expr");
    $$->settext("!" + $2->gettext());
    outlog << "At line no: " << lines << " unary_expression : NOT unary_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| factor {
    $$ = $1;
    outlog << "At line no: " << lines << " unary_expression : factor" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

factor : variable {
    $$ = $1;
    outlog << "At line no: " << lines << " factor : variable" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| ID LPAREN argument_list RPAREN {
    $$ = new symbol_info("", "func_call");
    $$->settext($1->getname() + "(" + $3->gettext() + ")");
    outlog << "At line no: " << lines << " factor : ID LPAREN argument_list RPAREN" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| LPAREN expression RPAREN {
    $$ = new symbol_info("", "factor");
    $$->settext("(" + $2->gettext() + ")");
    outlog << "At line no: " << lines << " factor : LPAREN expression RPAREN" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| CONST_INT {
    $$ = $1;
    outlog << "At line no: " << lines << " factor : CONST_INT" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| CONST_FLOAT {
    $$ = $1;
    outlog << "At line no: " << lines << " factor : CONST_FLOAT" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| variable INCOP {
    $$ = new symbol_info("", "postfix_expr");
    $$->settext($1->gettext() + $2->getname());
    outlog << "At line no: " << lines << " factor : variable INCOP" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| variable DECOP {
    $$ = new symbol_info("", "postfix_expr");
    $$->settext($1->gettext() + $2->getname());
    outlog << "At line no: " << lines << " factor : variable DECOP" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

argument_list : arguments {
    $$ = $1;
    outlog << "At line no: " << lines << " argument_list : arguments" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| {
    $$ = new symbol_info("", "arg_list");
    outlog << "At line no: " << lines << " argument_list : " << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

arguments : arguments COMMA logic_expression {
    $$ = new symbol_info("", "args");
    $$->settext($1->gettext() + ", " + $3->gettext());
    outlog << "At line no: " << lines << " arguments : arguments COMMA logic_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
| logic_expression {
    $$ = $1;
    outlog << "At line no: " << lines << " arguments : logic_expression" << endl << endl;
    outlog << $$->gettext() << endl << endl;
}
;

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        cout << "Usage: ./parser <input_file>" << endl;
        return 1;
    }

    yyin = fopen(argv[1], "r");
    lines = 1;
    outlog.open("24341220.txt", ios::trunc);

    if (yyin == NULL) {
        cout << "Couldn't open file" << endl;
        return 1;
    }

    yyparse();

    outlog << "Total lines: " << lines << endl;
    outlog.close();
    fclose(yyin);

    return 0;
}