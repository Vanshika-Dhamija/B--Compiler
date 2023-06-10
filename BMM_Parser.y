%{

#include <stdio.h>
#include <string.h>
#include <math.h>
int yylex();
void yyerror(char*);
extern FILE *yyin,*yyout,*lexresult;
int a=0;

%}

%token INT SINGPRE DOUBPRE STRINGTYPE EQUAL UNEQUAL LESS GREAT LESSEQ GREATEQ NOT AND OR XOR COMMA DATA DEF DIM END FOR TO STEP GOSUB GOTO IF THEN LET PRINT INVCOMMA INPUT RETURN STOP SEMICOLON NEXT REM NEWLINE
%union{
    int num;
    char *str;
}
%token <num> NUM
%token <str> VARNAME
%token <str> INVSTRING
%token <str> STRING
%token <str> SINGLETT
%left EXPO
%left PLUS MINUS
%left MULT DIV
%left LEFTBRAC RIGHTBRAC


%%

program : statements END
	| statements STOP program
;

statements : statement  	
	| statement statements
;



statement : NUM lineStatement NEWLINE		{fprintf(yyout, "line number- %d\n", a= $1);}
;	
lineStatement: data	{fprintf(yyout, "are the defined data in ");}
    | def	{fprintf(yyout, "defined by DEF in ");}
    | dim	{fprintf(yyout, "DIM statement in ");}
    | end	{fprintf(yyout, "Terminating by END statement in ");}
    | for	{fprintf(yyout, "by FOR statement in ");}
    | gosub	{fprintf(yyout, "from GOSUB statement in ");}
    | goto	{fprintf(yyout, "from GOTO statement in ");}
    | if	{fprintf(yyout, " by IF statement defined in ");}
    | let	{fprintf(yyout, " defined by LET statement in ");}
    | input	{fprintf(yyout, "used as input in ");}
    | print	{fprintf(yyout, "by PRINT statement in ");}
    | return	{fprintf(yyout, "RETURN statement in ");}
    | stop	{fprintf(yyout, "STOP statement in ");}
    | rem	{fprintf(yyout, "Comment detected in ");}
    | n1	{fprintf(yyout, "NEXT statement in");}
;

rem: REM 	
;
strings: STRING strings	
	| STRING	{fprintf(yyout, " %s ", $1);}
	| INVSTRING	{fprintf(yyout, " %s ", $1);}
; 

stringinvcomma: INVSTRING	{fprintf(yyout," %s ", $1);} 
;

operand: NUM	{fprintf(yyout, " %d ", $1);}
	| stringinvcomma 	
	| NUM COMMA operand 	{fprintf(yyout, " %d ", $1);}
	| stringinvcomma COMMA operand 	
;

data: DATA operand
;

def: DEF STRING LEFTBRAC STRINGS RIGHTBRAC EQUAL expression	{fprintf(yyout, " %s ", $2);}
	| DEF STRING EQUAL expression	{fprintf(yyout, " %s ", $2);}
;

dim: DIM declarations	
;

STRINGS: STRING STRINGS	
     | SINGLETT STRINGS	
     | SINGLETT		
     | STRING		
;

declarations: SINGLETT LEFTBRAC NUM RIGHTBRAC COMMA declarations
	| SINGLETT LEFTBRAC NUM RIGHTBRAC 	{fprintf(yyout, "Number in dim: %d\n", $3);}
	| SINGLETT LEFTBRAC NUM COMMA NUM RIGHTBRAC COMMA declarations
	| SINGLETT LEFTBRAC NUM COMMA NUM RIGHTBRAC	{fprintf(yyout, "Numbers in dim: %d, %d\n", $3, $5);}
;
end : END 	{}
;

declarationinput: SINGLETT LEFTBRAC varDeclaration RIGHTBRAC COMMA declarations
	| SINGLETT LEFTBRAC varDeclaration RIGHTBRAC 	
	| SINGLETT LEFTBRAC varDeclaration COMMA varDeclaration RIGHTBRAC COMMA declarations
	| SINGLETT LEFTBRAC varDeclaration COMMA varDeclaration RIGHTBRAC	
;

varDeclaration : VARNAME	{fprintf(yyout, "Variable named %s ", $1);}
    | VARNAME INT	{fprintf(yyout, "Integer type variable named %s ", $1);}
    | VARNAME SINGPRE	{fprintf(yyout, "Single precision variable named %s ", $1);}
    | VARNAME DOUBPRE	{fprintf(yyout, "Double precision variable named %s ", $1);}
    | VARNAME STRINGTYPE	{fprintf(yyout, "String type variable named %s ", $1);}
    | SINGLETT		{fprintf(yyout, "Variable named %s ", $1);}
    | SINGLETT INT	{fprintf(yyout, "Integer type variable named %s ", $1);}
    | SINGLETT SINGPRE	{fprintf(yyout, "Single precision variable named %s ", $1);}
    | SINGLETT DOUBPRE	{fprintf(yyout, "Double precision variable named %s ", $1);}
    | SINGLETT STRINGTYPE	{fprintf(yyout, "String type variable named %s ", $1);}
;
expression :  LEFTBRAC expression RIGHTBRAC
    | arithmetic
    | relational
    | logical
    | varDeclaration
    | NUM	{fprintf(yyout, "%d ", $1);}
    | STRING	{fprintf(yyout, "%s ", $1);}
    | stringinvcomma	
    | declarationinput
;

arithmetic : expression EXPO expression  {fprintf(yyout, " using expo operator ");}
    | expression MINUS expression	{fprintf(yyout, " using minus operator ");}
    | expression PLUS expression	{fprintf(yyout, " using addition operator ");}
    | expression MULT expression	{fprintf(yyout, " using multiplication operator ");}
    | expression DIV expression	{fprintf(yyout, " using division operator ");}
    | MINUS expression		{fprintf(yyout, " using negation operator ");}
;

relational : expression EQUAL expression	{fprintf(yyout, " using equal relational operator ");}
    | expression UNEQUAL expression	{fprintf(yyout, " using unequal relational operator ");}
    | expression LESS expression	{fprintf(yyout, " using less than relational operator ");}
    | expression GREAT expression	{fprintf(yyout, " using greater than relational operator ");}
    | expression LESSEQ expression	{fprintf(yyout, " using less than or equal to relational operator ");}
    | expression GREATEQ expression	{fprintf(yyout, " using greater than or equal to relational operator ");}
;

logical : expression NOT expression
    | expression AND expression
    | expression OR expression
    | expression XOR expression
;

for: f1 varDeclaration EQUAL expression t1 expression STEP expression 
	| f1 varDeclaration EQUAL expression t1 expression  
;

f1: FOR 	{fprintf(yyout, "For ");}
;

t1: TO		{{fprintf(yyout, "Till it is equal to ");}}
;

n1: NEXT SINGLETT	 
;

gosub: GOSUB NUM  {fprintf(yyout, "GOSUB statement sending to line no: %d ", $2);}
;
goto: GOTO NUM	{fprintf(yyout, "GOTO statement sending to line no: %d ", $2);}
;

vars: varDeclaration COMMA vars
	| declarations COMMA vars
	| declarationinput COMMA vars
	| varDeclaration
	| declarations
	| declarationinput
;
input: INPUT vars;

if: IF condition then expression; 
then: THEN	{fprintf(yyout, " then ");}
;

excon :  LEFTBRAC excon RIGHTBRAC
    | arithmetic
    | relational
    | logical
    | varDeclaration
    | NUM	
    | STRING
    | stringinvcomma
;
condition: expression EQUAL expression
    | expression UNEQUAL expression
;

     
let: LET varDeclaration EQUAL expression 	
	| LET VARNAME STRINGTYPE EQUAL stringinvcomma 
	| LET SINGLETT LEFTBRAC NUM RIGHTBRAC EQUAL  expression
	| LET SINGLETT LEFTBRAC NUM COMMA NUM RIGHTBRAC EQUAL  expression 
;


return: RETURN;



stop: STOP	
;
print: PRINT 
	| PRINT printvars 	
	;

printvars: varDeclaration delimiter printvars
	| stringinvcomma delimiter printvars
	| expression delimiter printvars
	| varDeclaration
	| stringinvcomma
	| expression
	| varDeclaration delimiter
	| expression delimiter
	| stringinvcomma delimiter
;

delimiter: COMMA | SEMICOLON;

%%
int main()
{
    yyin=fopen("CorrectSample.bmm","r");
    yyout=fopen("parser.txt","w");
    lexresult=fopen("lexer.txt","w");
    yyparse();
    return 0;
}

void yyerror(char*s){
    printf("Error \n");
}

