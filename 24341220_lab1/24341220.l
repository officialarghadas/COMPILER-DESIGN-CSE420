%option noyywrap

%{
#include <bits/stdc++.h>
#include "symbol_info.h"

#define YYSTYPE symbol_info*
#include "y.tab.h"

extern YYSTYPE yylval;
using namespace std;

void yyerror(char *);

extern int lines;
extern ofstream outlog;

string tokenMsg;

void writeLog(string tok, string lex) {
    tokenMsg = "Line no " + to_string(lines) + ": Token <" + tok + "> Lexeme " + lex + " found\n\n";
    outlog << tokenMsg;
}
%}

WHITESPACE  [ \t\v\r\f]+
NEWLINE     \n
ALPHA       [A-Za-z_]
DIGIT       [0-9]
IDENTIFIER  {ALPHA}({ALPHA}|{DIGIT})*
EXP_PART    [Ee][+-]?{DIGIT}+
FLOAT_NUM   {DIGIT}+\.{DIGIT}+{EXP_PART}?|{DIGIT}+{EXP_PART}|\.{DIGIT}+{EXP_PART}?
INT_NUM     {DIGIT}+

%%

{WHITESPACE}    { }
{NEWLINE}       { lines++; }

"if"        { writeLog("IF", yytext); return IF; }
"else"      { writeLog("ELSE", yytext); return ELSE; }
"for"       { writeLog("FOR", yytext); return FOR; }
"while"     { writeLog("WHILE", yytext); return WHILE; }
"do"        { writeLog("DO", yytext); return DO; }
"break"     { writeLog("BREAK", yytext); return BREAK; }
"int"       { writeLog("INT", yytext); return INT; }
"float"     { writeLog("FLOAT", yytext); return FLOAT; }
"void"      { writeLog("VOID", yytext); return VOID; }
"return"    { writeLog("RETURN", yytext); return RETURN; }
"switch"    { writeLog("SWITCH", yytext); return SWITCH; }
"case"      { writeLog("CASE", yytext); return CASE; }
"default"   { writeLog("DEFAULT", yytext); return DEFAULT; }
"continue"  { writeLog("CONTINUE", yytext); return CONTINUE; }
"goto"      { writeLog("GOTO", yytext); return GOTO; }
"println"   { writeLog("PRINTLN", yytext); return PRINTLN; }

{FLOAT_NUM} {
    yylval = new symbol_info(string(yytext), "CONST_FLOAT");
    writeLog("CONST_FLOAT", yytext);
    return CONST_FLOAT;
}

{INT_NUM} {
    yylval = new symbol_info(string(yytext), "CONST_INT");
    writeLog("CONST_INT", yytext);
    return CONST_INT;
}

{IDENTIFIER} {
    yylval = new symbol_info(string(yytext), "ID");
    writeLog("ID", yytext);
    return ID;
}

"++" {
    yylval = new symbol_info(string(yytext), "INCOP");
    writeLog("INCOP", yytext);
    return INCOP;
}

"--" {
    yylval = new symbol_info(string(yytext), "DECOP");
    writeLog("DECOP", yytext);
    return DECOP;
}

"+"|"-" {
    yylval = new symbol_info(string(yytext), "ADDOP");
    writeLog("ADDOP", yytext);
    return ADDOP;
}

"*"|"/"|"%" {
    yylval = new symbol_info(string(yytext), "MULOP");
    writeLog("MULOP", yytext);
    return MULOP;
}

"<="|">="|"=="|"!="|"<"|">" {
    yylval = new symbol_info(string(yytext), "RELOP");
    writeLog("RELOP", yytext);
    return RELOP;
}

"=" {
    writeLog("ASSIGNOP", yytext);
    return ASSIGNOP;
}

"&&"|"||" {
    yylval = new symbol_info(string(yytext), "LOGICOP");
    writeLog("LOGICOP", yytext);
    return LOGICOP;
}

"!" {
    writeLog("NOT", yytext);
    return NOT;
}

"(" { writeLog("LPAREN", yytext); return LPAREN; }
")" { writeLog("RPAREN", yytext); return RPAREN; }
"{" { writeLog("LCURL", yytext); return LCURL; }
"}" { writeLog("RCURL", yytext); return RCURL; }
"[" { writeLog("LTHIRD", yytext); return LTHIRD; }
"]" { writeLog("RTHIRD", yytext); return RTHIRD; }
"," { writeLog("COMMA", yytext); return COMMA; }
":" { writeLog("COLON", yytext); return COLON; }
";" { writeLog("SEMICOLON", yytext); return SEMICOLON; }

%%