D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

%{
#include <stdio.h>
#include "analisisSint.tab.h"
%}

%%

"auto"			{  printf("Clase por defecto.\n"); return(AUTO); }
"break"			{  printf("Romper ciclo.\n"); return(BREAK); }
"case"			{  printf("Caso.\n"); return(CASE); }
"char"			{  printf("Tipo de dato de caracter.\n"); return(CHAR); }
"const"			{  printf("Tipo de dato inalterable.\n"); return(CONST); }
"continue"		{  printf("Continuar a la siguiente iteracion.\n"); return(CONTINUE); }
"default"		{  printf("Caso por defecto.\n"); return(DEFAULT); }
"do"			{  printf("Instruccion do.\n"); return(DO); }
"double"		{  printf("Tipo de dato flotante.\n"); return(DOUBLE); }
"else"			{  printf("Instruccion else.\n"); return(ELSE); }
"enum"			{  printf("Tipo de dato enumerable.\n"); return(ENUM); }
"extern"		{  printf("Variable externa.\n"); return(EXTERN); }
"float"			{  printf("Tipo de dato flotante.\n");return(FLOAT); }
"for"			{  printf("Instruccion for.\n"); return(FOR); }
"goto"			{  printf("Instruccion foto.\n"); return(GOTO); }
"if"			{  printf("Instruccion if.\n");return(IF); }
"int"			{  printf("Tipo de dato entero.\n"); return(INT); }
"long"			{  printf("Tipo de dato inalterable.\n"); return(LONG); }
"register"		{  printf("Alargar el tipo de dato.\n"); return(REGISTER); }
"return"		{  printf("Funcion return.\n"); return(RETURN); }
"short"			{  printf("Acortar tipo de dato.\n"); return(SHORT); }
"signed"		{  return(SIGNED); }
"sizeof"		{  printf("Funcion sizeof.\n"); return(SIZEOF); }
"static"		{  printf("Tipo de dato estatico.\n"); return(STATIC); }
"struct"		{  printf("Definicio de estructura.\n"); return(STRUCT); }
"switch"		{  printf("Instruccion switch.\n"); return(SWITCH); }
"typedef"		{  printf("Typedef.\n"); return(TYPEDEF); }
"union"			{  printf("Union.\n"); return(UNION); }
"unsigned"		{  printf("Unsigned.\n"); return(UNSIGNED); }
"void"			{  printf("Void.\n"); return(VOID); }
"volatile"		{  printf("Volatile.\n"); return(VOLATILE); }
"while"			{  printf("Instruccion while.\n"); return(WHILE); }

{L}({L}|{D})*		{  printf("Identificador.\n"); return(IDENTIFIER); }

0[xX]{H}+{IS}?		{  printf("Constante.\n"); return(CONSTANT); }
0{D}+{IS}?		{  printf("Constante.\n"); return(CONSTANT); }
{D}+{IS}?		{  printf("Constante.\n"); return(CONSTANT); }
L?'(\\.|[^\\'])+'	{  printf("Constante.\n"); return(CONSTANT); }

{D}+{E}{FS}?		{  printf("Constante.\n"); return(CONSTANT); }
{D}*"."{D}+({E})?{FS}?	{  printf("Constante.\n"); return(CONSTANT); }
{D}+"."{D}*({E})?{FS}?	{  printf("Constante.\n"); return(CONSTANT); }

L?\"(\\.|[^\\"])*\"	{  printf("Literal tipo string.\n"); return(STRING_LITERAL); }

"..."			{  printf("Elipsis.\n"); return(ELLIPSIS); }
">>="			{  printf("Asignacion a la derecha.\n"); return(RIGHT_ASSIGN); }
"<<="			{  printf("Asignacion a la izquierda.\n"); return(LEFT_ASSIGN); }
"+="			{  printf("Asignacion con suma.\n"); return(ADD_ASSIGN); }
"-="			{  printf("Asignacion con resta.\n"); return(SUB_ASSIGN); }
"*="			{  printf("Asignacion con multiplicacion.\n"); return(MUL_ASSIGN); }
"/="			{  printf("Asignacion con divicion.\n"); return(DIV_ASSIGN); }
"%="			{  printf("Asignacion con modulo.\n"); return(MOD_ASSIGN); }
"&="			{  printf("Asignacion con AND.\n"); return(AND_ASSIGN); }
"^="			{  printf("Asignacion con XOR.\n"); return(XOR_ASSIGN); }
"|="			{  printf("Asignacion con OR.\n"); return(OR_ASSIGN); }
">>"			{  printf("Rigth shift.\n"); return(RIGHT_OP); }
"<<"			{  printf("Left shift.\n"); return(LEFT_OP); }
"++"			{  printf("Mas mas.\n");return(INC_OP); }
"--"			{  printf("Menos menos.\n"); return(DEC_OP); }
"->"			{  printf("Apuntador.\n"); return(PTR_OP); }
"&&"			{  printf("AND.\n"); return(AND_OP); }
"||"			{  printf("OR.\n");return(OR_OP); }
"<="			{  printf("Menor o igual a.\n"); return(LE_OP); }
">="			{  printf("Mayor o igual a.\n"); return(GE_OP); }
"=="			{  printf("Igual a.\n");return(EQ_OP); }
"!="			{  printf("Diferente a.\n"); return(NE_OP); }
";"			{  printf("Fin de linea.\n"); return(';'); }
("{"|"<%")		{  printf("Abre llave.\n"); return('{'); }
("}"|"%>")		{  printf("Cierra llave.\n"); return('}'); }
","			{  printf("Coma.\n"); return(','); }
":"			{  printf("Dos puntos.\n");  return(':'); }
"="			{  printf("Igual.\n"); return('='); }
"("			{  printf("Abre parentesis.\n"); return('('); }
")"			{  printf("Cierra parentesis.\n"); return(')'); }
("["|"<:")		{  printf("Abre corchete.\n"); return('['); }
("]"|":>")		{  printf("Cierra corchete.\n"); return(']'); }
"."			{  printf("Punto.\n"); return('.'); }
"&"			{  printf("Andpersant.\n"); return('&'); }
"!"			{  printf("Admiracion.\n"); return('!'); }
"~"			{  printf("Virgulilla.\n"); return('~'); }
"-"			{  printf("Signo negativo.\n"); return('-'); }
"+"			{  printf("Signo positivo.\n"); return('+'); }
"*"			{  printf("Asterisco.\n"); return('*'); }
"/"			{  printf("Diagonal.\n"); return('/'); }
"%"			{  printf("Porsentaje.\n"); return('%'); }
"<"			{  printf("Menor que.\n"); return('<'); }
">"			{  printf("Mayor que.\n"); return('>'); }
"^"			{  printf("Potencia.\n"); return('^'); }
"|"			{  printf("Barra.\n"); return('|'); }
"?"			{  printf("Signo de interrogacion.\n"); return('?'); }

[ \t\v\n\f]		{  }
.			{  }

%%
