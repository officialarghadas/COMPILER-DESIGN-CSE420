/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INT = 258,
     FLOAT = 259,
     VOID = 260,
     IF = 261,
     ELSE = 262,
     FOR = 263,
     WHILE = 264,
     DO = 265,
     BREAK = 266,
     RETURN = 267,
     SWITCH = 268,
     CASE = 269,
     DEFAULT = 270,
     CONTINUE = 271,
     GOTO = 272,
     PRINTLN = 273,
     SEMICOLON = 274,
     COMMA = 275,
     COLON = 276,
     LCURL = 277,
     RCURL = 278,
     LPAREN = 279,
     RPAREN = 280,
     LTHIRD = 281,
     RTHIRD = 282,
     ID = 283,
     CONST_INT = 284,
     CONST_FLOAT = 285,
     ADDOP = 286,
     MULOP = 287,
     INCOP = 288,
     DECOP = 289,
     RELOP = 290,
     ASSIGNOP = 291,
     LOGICOP = 292,
     NOT = 293,
     LOWER_THAN_ELSE = 294
   };
#endif
/* Tokens.  */
#define INT 258
#define FLOAT 259
#define VOID 260
#define IF 261
#define ELSE 262
#define FOR 263
#define WHILE 264
#define DO 265
#define BREAK 266
#define RETURN 267
#define SWITCH 268
#define CASE 269
#define DEFAULT 270
#define CONTINUE 271
#define GOTO 272
#define PRINTLN 273
#define SEMICOLON 274
#define COMMA 275
#define COLON 276
#define LCURL 277
#define RCURL 278
#define LPAREN 279
#define RPAREN 280
#define LTHIRD 281
#define RTHIRD 282
#define ID 283
#define CONST_INT 284
#define CONST_FLOAT 285
#define ADDOP 286
#define MULOP 287
#define INCOP 288
#define DECOP 289
#define RELOP 290
#define ASSIGNOP 291
#define LOGICOP 292
#define NOT 293
#define LOWER_THAN_ELSE 294



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
