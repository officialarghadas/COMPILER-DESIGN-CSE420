%{

#include "symbol_info.h"

#define YYSTYPE symbol_info*

int yyparse(void);
int yylex(void);
extern FILE *yyin;

ofstream outlog;
int lines;

void logRule(string rule, string text) {
    outlog << "At line no: " << lines << " " << rule << endl << endl;
    outlog << text << endl << endl;
}

void yyerror(const char *s) {
    outlog << "Error: " << s << " at line " << lines << endl;
}

symbol_info* makeNode(string nm, string tp, string txt) {
    symbol_info* node = new symbol_info(nm, tp);
    node->settext(txt);
    return node;
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
    logRule("start : program", $1->gettext());
}
;

program : program unit {
    string combined = $1->gettext() + "\n" + $2->gettext();
    $$ = makeNode("", "program", combined);
    logRule("program : program unit", $$->gettext());
}
| unit {
    $$ = $1;
    logRule("program : unit", $$->gettext());
}
;

unit : var_declaration {
    $$ = $1;
    logRule("unit : var_declaration", $$->gettext());
}
| func_definition {
    $$ = $1;
    logRule("unit : func_definition", $$->gettext());
}
;

func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement {
    string result = $1->gettext() + " " + $2->getname() + "(" + $4->gettext() + ")\n" + $6->gettext();
    $$ = makeNode("", "func_def", result);
    logRule("func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement", $$->gettext());
}
| type_specifier ID LPAREN RPAREN compound_statement {
    string result = $1->gettext() + " " + $2->getname() + "()\n" + $5->gettext();
    $$ = makeNode("", "func_def", result);
    logRule("func_definition : type_specifier ID LPAREN RPAREN compound_statement", $$->gettext());
}
;

parameter_list : parameter_list COMMA type_specifier ID {
    string result = $1->gettext() + ", " + $3->gettext() + " " + $4->getname();
    $$ = makeNode("", "param_list", result);
    logRule("parameter_list : parameter_list COMMA type_specifier ID", $$->gettext());
}
| parameter_list COMMA type_specifier {
    string result = $1->gettext() + ", " + $3->gettext();
    $$ = makeNode("", "param_list", result);
    logRule("parameter_list : parameter_list COMMA type_specifier", $$->gettext());
}
| type_specifier ID {
    string result = $1->gettext() + " " + $2->getname();
    $$ = makeNode("", "param_list", result);
    logRule("parameter_list : type_specifier ID", $$->gettext());
}
| type_specifier {
    $$ = $1;
    logRule("parameter_list : type_specifier", $$->gettext());
}
;

compound_statement : LCURL statements RCURL {
    string result = "{\n" + $2->gettext() + "\n}";
    $$ = makeNode("", "compound", result);
    logRule("compound_statement : LCURL statements RCURL", $$->gettext());
}
| LCURL RCURL {
    $$ = makeNode("", "compound", "{}");
    logRule("compound_statement : LCURL RCURL", $$->gettext());
}
;

var_declaration : type_specifier declaration_list SEMICOLON {
    string result = $1->gettext() + " " + $2->gettext() + ";";
    $$ = makeNode("", "var_decl", result);
    logRule("var_declaration : type_specifier declaration_list SEMICOLON", $$->gettext());
}
;

type_specifier : INT {
    $$ = new symbol_info("int", "type");
    logRule("type_specifier : INT", $$->gettext());
}
| FLOAT {
    $$ = new symbol_info("float", "type");
    logRule("type_specifier : FLOAT", $$->gettext());
}
| VOID {
    $$ = new symbol_info("void", "type");
    logRule("type_specifier : VOID", $$->gettext());
}
;

declaration_list : declaration_list COMMA ID {
    string result = $1->gettext() + ", " + $3->getname();
    $$ = makeNode("", "decl_list", result);
    logRule("declaration_list : declaration_list COMMA ID", $$->gettext());
}
| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD {
    string result = $1->gettext() + ", " + $3->getname() + "[" + $5->getname() + "]";
    $$ = makeNode("", "decl_list", result);
    logRule("declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD", $$->gettext());
}
| ID {
    $$ = $1;
    logRule("declaration_list : ID", $$->gettext());
}
| ID LTHIRD CONST_INT RTHIRD {
    string result = $1->getname() + "[" + $3->getname() + "]";
    $$ = makeNode("", "decl_list", result);
    logRule("de claration_list : ID LTHIRD CONST_INT RTHIRD", $$->gettext());
}
;

statements : statement {
    $$ = $1;
    logRule("statements : statement", $$->gettext());
}
| statements statement {
    string result = $1->gettext() + "\n" + $2->gettext();
    $$ = makeNode("", "statements", result);
    logRule("statements : statements statement", $$->gettext());
}
;

statement : var_declaration {
    $$ = $1;
    logRule("statement : var_declaration", $$->gettext());
}
| expression_statement {
    $$ = $1;
    logRule("statement : expression_statement", $$->gettext());
}
| compound_statement {
    $$ = $1;
    logRule("statement : compound_statement", $$->gettext());
}
| FOR LPAREN expression_statement expression_statement expression RPAREN statement {
    string result = "for(" + $3->gettext() + " " + $4->gettext() + " " + $5->gettext() + ")\n" + $7->gettext();
    $$ = makeNode("", "for_stmt", result);
    logRule("statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement", $$->gettext());
}
| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
    string result = "if(" + $3->gettext() + ")\n" + $5->gettext();
    $$ = makeNode("", "if_stmt", result);
    logRule("statement : IF LPAREN expression RPAREN statement", $$->gettext());
}
| IF LPAREN expression RPAREN statement ELSE statement {
    string result = "if(" + $3->gettext() + ")\n" + $5->gettext() + "\nelse\n" + $7->gettext();
    $$ = makeNode("", "if_else_stmt", result);
    logRule("statement : IF LPAREN expression RPAREN statement ELSE statement", $$->gettext());
}
| WHILE LPAREN expression RPAREN statement {
    string result = "while(" + $3->gettext() + ")\n" + $5->gettext();
    $$ = makeNode("", "while_stmt", result);
    logRule("statement : WHILE LPAREN expression RPAREN statement", $$->gettext());
}
| PRINTLN LPAREN ID RPAREN SEMICOLON {
    string result = "println(" + $3->getname() + ");";
    $$ = makeNode("", "println_stmt", result);
    logRule("statement : PRINTLN LPAREN ID RPAREN SEMICOLON", $$->gettext());
}
| RETURN expression SEMICOLON {
    string result = "return " + $2->gettext() + ";";
    $$ = makeNode("", "return_stmt", result);
    logRule("statement : RETURN expression SEMICOLON", $$->gettext());
}
;

expression_statement : SEMICOLON {
    $$ = new symbol_info(";", "expr_stmt");
    logRule("expression_statement : SEMICOLON", $$->gettext());
}
| expression SEMICOLON {
    string result = $1->gettext() + ";";
    $$ = makeNode("", "expr_stmt", result);
    logRule("expression_statement : expression SEMICOLON", $$->gettext());
}
;

variable : ID {
    $$ = $1;
    logRule("variable : ID", $$->gettext());
}
| ID LTHIRD expression RTHIRD {
    string result = $1->getname() + "[" + $3->gettext() + "]";
    $$ = makeNode("", "var_array", result);
    logRule("variable : ID LTHIRD expression RTHIRD", $$->gettext());
}
;

expression : logic_expression {
    $$ = $1;
    logRule("expression : logic_expression", $$->gettext());
}
| variable ASSIGNOP logic_expression {
    string result = $1->gettext() + "=" + $3->gettext();
    $$ = makeNode("", "assign_expr", result);
    logRule("expression : variable ASSIGNOP logic_expression", $$->gettext());
}
;

logic_expression : rel_expression {
    $$ = $1;
    logRule("logic_expression : rel_expression", $$->gettext());
}
| rel_expression LOGICOP rel_expression {
    string result = $1->gettext() + $2->getname() + $3->gettext();
    $$ = makeNode("", "logic_expr", result);
    logRule("logic_expression : rel_expression LOGICOP rel_expression", $$->gettext());
}
;

rel_expression : simple_expression {
    $$ = $1;
    logRule("rel_expression : simple_expression", $$->gettext());
}
| simple_expression RELOP simple_expression {
    string result = $1->gettext() + $2->getname() + $3->gettext();
    $$ = makeNode("", "rel_expr", result);
    logRule("rel_expression : simple_expression RELOP simple_expression", $$->gettext());
}
;

simple_expression : term {
    $$ = $1;
    logRule("simple_expression : term", $$->gettext());
}
| simple_expression ADDOP term {
    string result = $1->gettext() + $2->getname() + $3->gettext();
    $$ = makeNode("", "simple_expr", result);
    logRule("simple_expression : simple_expression ADDOP term", $$->gettext());
}
;

term : unary_expression {
    $$ = $1;
    logRule("term : unary_expression", $$->gettext());
}
| term MULOP unary_expression {
    string result = $1->gettext() + $2->getname() + $3->gettext();
    $$ = makeNode("", "term", result);
    logRule("term : term MULOP unary_expression", $$->gettext());
}
;

unary_expression : ADDOP unary_expression {
    string result = $1->getname() + $2->gettext();
    $$ = makeNode("", "unary_expr", result);
    logRule("unary_expression : ADDOP unary_expression", $$->gettext());
}
| NOT unary_expression {
    string result = "!" + $2->gettext();
    $$ = makeNode("", "unary_expr", result);
    logRule("unary_expression : NOT unary_expression", $$->gettext());
}
| factor {
    $$ = $1;
    logRule("unary_expression : factor", $$->gettext());
}
;

factor : variable {
    $$ = $1;
    logRule("factor : variable", $$->gettext());
}
| ID LPAREN argument_list RPAREN {
    string result = $1->getname() + "(" + $3->gettext() + ")";
    $$ = makeNode("", "func_call", result);
    logRule("factor : ID LPAREN argument_list RPAREN", $$->gettext());
}
| LPAREN expression RPAREN {
    string result = "(" + $2->gettext() + ")";
    $$ = makeNode("", "factor", result);
    logRule("factor : LPAREN expression RPAREN", $$->gettext());
}
| CONST_INT {
    $$ = $1;
    logRule("factor : CONST_INT", $$->gettext());
}
| CONST_FLOAT {
    $$ = $1;
    logRule("factor : CONST_FLOAT", $$->gettext());
}
| variable INCOP {
    string result = $1->gettext() + $2->getname();
    $$ = makeNode("", "postfix_expr", result);
    logRule("factor : variable INCOP", $$->gettext());
}
| variable DECOP {
    string result = $1->gettext() + $2->getname();
    $$ = makeNode("", "postfix_expr", result);
    logRule("factor : variable DECOP", $$->gettext());
}
;

argument_list : arguments {
    $$ = $1;
    logRule("argument_list : arguments", $$->gettext());
}
| {
    $$ = new symbol_info("", "arg_list");
    logRule("argument_list : ", $$->gettext());
}
;

arguments : arguments COMMA logic_expression {
    string result = $1->gettext() + ", " + $3->gettext();
    $$ = makeNode("", "args", result);
    logRule("arguments : arguments COMMA logic_expression", $$->gettext());
}
| logic_expression {
    $$ = $1;
    logRule("arguments : logic_expression", $$->gettext());
}
;

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        cout << "Usage: ./parser <input_file>" << endl;
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    if (fp == NULL) {
        cout << "Couldn't open file" << endl;
        return 1;
    }

    yyin = fp;
    lines = 1;
    outlog.open("24341220.txt", ios::trunc);

    yyparse();

    outlog << "Total lines: " << lines << endl;
    outlog.close();
    fclose(yyin);

    return 0;
}