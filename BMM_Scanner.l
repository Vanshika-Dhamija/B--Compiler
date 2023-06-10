%{

#include <stdio.h>
#include <string.h>
#include <math.h>
FILE *lexresult;
#include "y.tab.h"
%}


%%
"REM"[ \t]*.* 	 {fprintf(lexresult, "COMMENT\n"); return REM;}
\".*\"	 	 {fprintf (lexresult,"INVSTRING : %s\n", yylval.str= yytext); return INVSTRING;}
[A-Z]([0-9]) 	 {fprintf(lexresult, "ID: %s\n", yytext);return VARNAME;}
"%"   		 {fprintf(lexresult, "Data type: Integer\n"); return INT;}
"!"   		 {fprintf(lexresult, "Data type: Single precision\n"); return SINGPRE;}
"#"   		 {fprintf(lexresult, "Data type: Double precision\n"); return DOUBPRE;}
"$"   		 {fprintf(lexresult, "Data type: String\n"); return STRINGTYPE;}
[\(]   	 {fprintf(lexresult, "LEFTBRAC: (\n");return LEFTBRAC;}
[\)]   	 {fprintf(lexresult, "RIGHTBRAC: )\n");return RIGHTBRAC;}
"^"   		 {fprintf(lexresult, "EXPO: ^\n"); return EXPO;}
"-"   		 {fprintf(lexresult, "MINUS: -\n"); return MINUS;}
"+"   		 {fprintf(lexresult, "PLUS: +\n"); return PLUS;}
"*"   		 {fprintf(lexresult, "MULTIPLY: *\n"); return MULT;}
"/"   		 {fprintf(lexresult, "DIVIDE: /\n"); return DIV;}
"="   		 {fprintf(lexresult, "COMPARE: equal\n"); return EQUAL;}
"<>"   	 {fprintf(lexresult, "COMPARE: unequal\n"); return UNEQUAL;}
"<"   		 {fprintf(lexresult, "COMPARE: lessThan\n"); return LESS;}
">"   		 {fprintf(lexresult, "COMPARE: greaterThan\n"); return GREAT;}
"<="   	 {fprintf(lexresult, "COMPARE: lessThanEqual\n"); return LESSEQ;}
">="   	 {fprintf(lexresult, "COMPARE: greaterThanEqual\n"); return GREATEQ;}
"NOT"   	 {fprintf(lexresult, "LOGICAL OP: not\n");return NOT;}
"AND"   	 {fprintf(lexresult, "LOGICAL OP: and\n"); return AND;}
"OR"   	 {fprintf(lexresult, "LOGICAL OP: or\n");return OR;}
"XOR"   	 {fprintf(lexresult, "LOGICAL OP: xor\n");return XOR;}
","   		 {fprintf(lexresult, "COMMA: ,\n"); return COMMA;}
"DATA"   	 {fprintf(lexresult, "STATEMENT: data\n"); return DATA;}
"DEF"   	 {fprintf(lexresult, "STATEMENT: def\n");return DEF;}
"NEXT"   	 {fprintf(lexresult, "STATEMENT: next\n"); return NEXT;}
"DIM"   	 {fprintf(lexresult, "STATEMENT: dim\n"); return DIM;}
"END"   	 {fprintf(lexresult, "TERMINATION: end\n"); return END;}
"FOR"   	 {fprintf(lexresult, "STATEMENT: for\n"); return FOR;}
"TO"   	 {fprintf(lexresult, "STATEMENT: to\n"); return TO;}
"STEP"   	 {fprintf(lexresult, "STATEMENT: step\n"); return STEP;}
"GOSUB"   	 {fprintf(lexresult, "STATEMENT: gosub\n"); return GOSUB;}
"GOTO"   	 {fprintf(lexresult, "STATEMENT: goto\n"); return GOTO;}
"IF"   	 {fprintf(lexresult, "STATEMENT: if\n"); return IF;}
"THEN"   	 {fprintf(lexresult, "STATEMENT: then\n"); return THEN;}
"LET"   	 {fprintf(lexresult, "STATEMENT: let\n"); return LET;}
"PRINT"   	 {fprintf(lexresult, "STATEMENT: print\n"); return PRINT;}
[\"]   	 {fprintf(lexresult, "INVERTED COMMA: \"\n"); return INVCOMMA;}
"INPUT"   	 {fprintf(lexresult, "STATEMENT: input\n"); return INPUT;}
"RETURN"   	 {fprintf(lexresult, "STATEMENT: return\n"); return RETURN;}
"STOP"   	 {fprintf(lexresult, "STATEMENT: stop\n"); return STOP;}
[0-9]+          {fprintf (lexresult,"NUM : %d\n", yylval.num= atoi(yytext)); return NUM;}
[ \t]+          ;
"\n"		{fprintf(lexresult, "-----NEW LINE-----\n"); return NEWLINE;}
";"             {fprintf (lexresult,"SEMICOLON : ;\n"); return SEMICOLON;}
[A-Z]		{fprintf (lexresult,"SINGLETT : %s\n", yylval.str= yytext); return SINGLETT;}
[A-Z]{2,}	{fprintf (lexresult,"STRING : %s\n", yylval.str= yytext); return STRING;}


%%

int yywrap(){
	return 1;
}

/*
int main()
{
    yyin=fopen("CorrectSample.bmm","r");
    lexresult=fopen("lexer.txt","w");
    yylex();
    return 0;
}
*/


