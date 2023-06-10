%{

#include <stdio.h>
#include <string.h>
#include <math.h>
FILE *lexresult;
%}


%%
"REM"[ \t]*.* 	 {fprintf(lexresult, "COMMENT\n");}
[A-Z]([0-9]) 	 {fprintf(lexresult, "ID: %s\n", yytext);}
"%"   		 {fprintf(lexresult, "Data type: Integer\n");}
"!"   		 {fprintf(lexresult, "Data type: Single precision\n");}
"#"   		 {fprintf(lexresult, "Data type: Double precision\n");}
"$"   		 {fprintf(lexresult, "Data type: String\n");}
[\(]   	 {fprintf(lexresult, "LEFTBRAC: (\n");}
[\)]   	 {fprintf(lexresult, "RIGHTBRAC: )\n");}
"^"   		 {fprintf(lexresult, "EXPO: ^\n");}
"-"   		 {fprintf(lexresult, "MINUS: -\n");}
"+"   		 {fprintf(lexresult, "PLUS: +\n");}
"*"   		 {fprintf(lexresult, "MULTIPLY: *\n");}
"/"   		 {fprintf(lexresult, "DIVIDE: /\n");}
"="   		 {fprintf(lexresult, "COMPARE: equal\n");}
"<>"   	 {fprintf(lexresult, "COMPARE: unequal\n");}
"<"   		 {fprintf(lexresult, "COMPARE: lessThan\n");}
">"   		 {fprintf(lexresult, "COMPARE: greaterThan\n"); }
"<="   	 {fprintf(lexresult, "COMPARE: lessThanEqual\n");}
">="   	 {fprintf(lexresult, "COMPARE: greaterThanEqual\n");}
"NOT"   	 {fprintf(lexresult, "LOGICAL OP: not\n");}
"AND"   	 {fprintf(lexresult, "LOGICAL OP: and\n"); }
"OR"   	 {fprintf(lexresult, "LOGICAL OP: or\n");}
"XOR"   	 {fprintf(lexresult, "LOGICAL OP: xor\n");}
","   		 {fprintf(lexresult, "COMMA: ,\n"); }
"DATA"   	 {fprintf(lexresult, "STATEMENT: data\n");}
"DEF"   	 {fprintf(lexresult, "STATEMENT: def\n");}
"DIM"   	 {fprintf(lexresult, "STATEMENT: dim\n");}
"END"   	 {fprintf(lexresult, "TERMINATION: end\n");}
"FOR"   	 {fprintf(lexresult, "STATEMENT: for\n"); }
"TO"   	 {fprintf(lexresult, "STATEMENT: to\n");}
"STEP"   	 {fprintf(lexresult, "STATEMENT: step\n"); }
"GOSUB"   	 {fprintf(lexresult, "STATEMENT: gosub\n");}
"GOTO"   	 {fprintf(lexresult, "STATEMENT: goto\n"); }
"IF"   	 {fprintf(lexresult, "STATEMENT: if\n"); }
"THEN"   	 {fprintf(lexresult, "STATEMENT: then\n"); }
"LET"   	 {fprintf(lexresult, "STATEMENT: let\n"); }
"PRINT"   	 {fprintf(lexresult, "STATEMENT: print\n");}
[\"]   	 {fprintf(lexresult, "INVERTED COMMA: \"\n");}
"INPUT"   	 {fprintf(lexresult, "STATEMENT: input\n");}

"RETURN"   	 {fprintf(lexresult, "STATEMENT: return\n"); }
"STOP"   	 {fprintf(lexresult, "STATEMENT: stop\n"); }
[0-9]+          {fprintf (lexresult,"NUM : %d\n", atoi(yytext));}
[ \t\n]+        ;
";"             {fprintf (lexresult,"SEMICOLON : ;\n"); }
[A-Z]		{fprintf (lexresult,"SINGLETT : %s\n", yytext); }
[A-Z]{2,}		{fprintf (lexresult,"STRING : %s\n", yytext);}


%%

int yywrap(){
	return 1;
}

int main()
{
    yyin=fopen("CorrectSample.bmm","r");
    lexresult=fopen("lexer.txt","w");
    yylex();
    return 0;
}

