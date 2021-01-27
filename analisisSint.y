%{
#include <stdio.h>
#include <stdlib.h>
/* MANEJO DE ERRORES */
void yyerror(char *mensaje){
	printf("ERROR: %s\n", mensaje); 
	exit(0);
}

%}

%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN TYPE_NAME TYPEDEF EXTERN STATIC AUTO REGISTER CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID STRUCT UNION ENUM ELLIPSIS CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start translation_unit
%%

primary_expression
	: IDENTIFIER
	| CONSTANT 					{printf("Expresion primaria.\n");}
	| STRING_LITERAL 			{printf("Expresion primaria.\n");}
	| '(' expression ')' 		{printf("Expresion primaria.\n");}
	;

postfix_expression
	: primary_expression 										
	| postfix_expression '[' expression ']' 					{printf("Expresion posfija.\n");}
	| postfix_expression '(' ')' 								{printf("Expresion posfija.\n");}
	| postfix_expression '(' argument_expression_list ')' 		{printf("Expresion posfija.\n");}
	| postfix_expression '.' IDENTIFIER 						{printf("Expresion posfija.\n");}
	| postfix_expression PTR_OP IDENTIFIER 						{printf("Expresion posfija.\n");}
	| postfix_expression INC_OP  								{printf("Expresion posfija.\n");}
	| postfix_expression DEC_OP 								{printf("Expresion posfija.\n");}
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression 		{printf("Lista de argumentos de expresion.\n");}
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression 				{printf("Expresion unitaria.\n");}
	| DEC_OP unary_expression 				{printf("Expresion unitaria.\n");}
	| unary_operator cast_expression 		{printf("Expresion unitaria.\n");}
	| SIZEOF unary_expression				{printf("Expresion unitaria.\n");}
	| SIZEOF '(' type_name ')'				{printf("Expresion unitaria.\n");}
	;

unary_operator
	: '&' 		{printf("Operador unitario.\n");}
	| '*' 		{printf("Operador unitario.\n");}
	| '+' 		{printf("Operador unitario.\n");}
	| '-' 		{printf("Operador unitario.\n");}
	| '~' 		{printf("Operador unitario.\n");}
	| '!' 		{printf("Operador unitario.\n");}
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression 	{printf("Expresion de casteo.\n");}
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression 	{printf("Multiplicacion.\n");}
	| multiplicative_expression '/' cast_expression 	{printf("Division.\n");}
	| multiplicative_expression '%' cast_expression 	{printf("Modulo.\n");}	
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression 	{printf("Suma.\n");}
	| additive_expression '-' multiplicative_expression 	{printf("Resta.\n");}
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression			{printf("Shift Izquierdo.\n");}
	| shift_expression RIGHT_OP additive_expression			{printf("Shift Derecho.\n");}
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression 		{printf("Menor Que.\n");}
	| relational_expression '>' shift_expression 		{printf("Mayor Que.\n");}	
	| relational_expression LE_OP shift_expression 		
	| relational_expression GE_OP shift_expression
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression	{printf("Asignacion.\n");}
	| equality_expression NE_OP relational_expression
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression 			{printf("Operacion AND.\n");}
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression 		{printf("Operacion de potencia.\n");}
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression 	{printf("Operacion OR.\n");}
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression 	{printf("Operacion And logica.\n");}
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression 		{printf("Operacion OR logica.\n");}
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression	{printf("Expresion condicional.\n");}
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression 		{printf("Expresion de asignacion.\n");}
	;

assignment_operator
	: '='
	| MUL_ASSIGN	{printf("Operador de asignacion.\n");}
	| DIV_ASSIGN	{printf("Operador de asignacion.\n");}
	| MOD_ASSIGN	{printf("Operador de asignacion.\n");}
	| ADD_ASSIGN	{printf("Operador de asignacion.\n");}
	| SUB_ASSIGN	{printf("Operador de asignacion.\n");}
	| LEFT_ASSIGN	{printf("Operador de asignacion.\n");}
	| RIGHT_ASSIGN	{printf("Operador de asignacion.\n");}
	| AND_ASSIGN	{printf("Operador de asignacion.\n");}
	| XOR_ASSIGN	{printf("Operador de asignacion.\n");}
	| OR_ASSIGN		{printf("Operador de asignacion.\n");}
	;

expression
	: assignment_expression
	| expression ',' assignment_expression	{printf("Expresion.\n");}
	;

constant_expression
	: conditional_expression	{printf("Expresion.\n");}
	;

declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';'	{printf("Declaracion.\n");}
	;

declaration_specifiers
	: storage_class_specifier
	| storage_class_specifier declaration_specifiers	{printf("Especificadores de declaracion.\n");}
	| type_specifier									{printf("Especificadores de declaracion.\n");}
	| type_specifier declaration_specifiers				{printf("Especificadores de declaracion.\n");}
	| type_qualifier 									{printf("Especificadores de declaracion.\n");}
	| type_qualifier declaration_specifiers				{printf("Especificadores de declaracion.\n");}
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator 			{printf("Lista de delaracion de iniciacion.\n");}
	;

init_declarator
	: declarator 
	| declarator '=' initializer 						{printf("Declaracion de inicializacion.\n");}
	;

storage_class_specifier
	: TYPEDEF
	| EXTERN 			{printf("Especificador de clase de inventario\n");}
	| STATIC			{printf("Especificador de clase de inventario\n");}
	| AUTO				{printf("Especificador de clase de inventario\n");}
	| REGISTER			{printf("Especificador de clase de inventario\n");}
	;

type_specifier
	: VOID    						{printf("Especificador de tipo.\n");}
	| CHAR 							{printf("Especificador de tipo.\n");}
	| SHORT 						{printf("Especificador de tipo.\n");}
	| INT 							{printf("Especificador de tipo.\n");}
	| LONG 						 	{printf("Especificador de tipo.\n");}
	| FLOAT 						{printf("Especificador de tipo.\n");}
	| DOUBLE 						{printf("Especificador de tipo.\n");}
	| SIGNED 						{printf("Especificador de tipo.\n");}
	| UNSIGNED						{printf("Especificador de tipo.\n");}
	| struct_or_union_specifier 	{printf("Especificador de tipo.\n");}
	| enum_specifier 				{printf("Especificador de tipo.\n");}
	| TYPE_NAME 					{printf("Especificador de tipo.\n");}
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}' 	{printf("Especificador de estructura o union.\n");}
	| struct_or_union '{' struct_declaration_list '}' 				{printf("Especificador de estructura o union.\n");}
	| struct_or_union IDENTIFIER 									{printf("Especificador de estructura o union.\n");}
	;

struct_or_union
	: STRUCT
	| UNION 		{printf("Estructura o union.\n");}
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration 	{printf("Lista de declaracion de estructura.\n");}
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';' 	{printf("Declaracion de estructura.\n");}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier 							{printf("Lista de cualificadores\n");}
	| type_qualifier specifier_qualifier_list 	{printf("Lista de cualificadores\n");}
	| type_qualifier 							{printf("Lista de cualificadores\n");}
	;

struct_declarator_list
	: struct_declarator 								
	| struct_declarator_list ',' struct_declarator 	{printf("Lista de declaraciones de estructura.\n");}
	;

struct_declarator
	: declarator
	| ':' constant_expression	 					{printf("Declaraciones de estructura.\n");}
	| declarator ':' constant_expression 			{printf("Declaraciones de estructura.\n");}
	;

enum_specifier
	: ENUM '{' enumerator_list '}'
	| ENUM IDENTIFIER '{' enumerator_list '}' 		{printf("ESpecificador de enumerador.\n");}
	| ENUM IDENTIFIER 								{printf("ESpecificador de enumerador.\n");}
	;

enumerator_list
	: enumerator
	| enumerator_list ',' enumerator 			 	{printf("Lista de enuemeradores.\n");}
	;

enumerator
	: IDENTIFIER
	| IDENTIFIER '=' constant_expression 			{printf("Enumerador.\n");}
	;

type_qualifier
	: CONST
	| VOLATILE 		{printf("Tipo de cualificador.\n");}
	;

declarator
	: pointer direct_declarator
	| direct_declarator 		{printf("Declarador.\n");}
	;

direct_declarator
	: IDENTIFIER
	| '(' declarator ')' 						 		{printf("Declarador directo.\n");}
	| direct_declarator '[' constant_expression ']'		{printf("Declarador directo.\n");}
	| direct_declarator '[' ']'							{printf("Declarador directo.\n");}
	| direct_declarator '(' parameter_type_list ')'		{printf("Declarador directo.\n");}
	| direct_declarator '(' identifier_list ')'			{printf("Declarador directo.\n");}
	| direct_declarator '(' ')'							{printf("Declarador directo.\n");}
	;

pointer
	: '*'
	| '*' type_qualifier_list 					{printf("Apuntador.\n");}
	| '*' pointer								{printf("Apuntador.\n");}
	| '*' type_qualifier_list pointer			{printf("Apuntador.\n");}
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier 		{printf("Lista de cualificador de tipo.\n");}
	;


parameter_type_list
	: parameter_list
	| parameter_list ',' ELLIPSIS 				{printf("Lista de tipos de parametros.\n");}
	;

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration 		{printf("Lista de parametros.\n");}
	;

parameter_declaration
	: declaration_specifiers declarator
	| declaration_specifiers abstract_declarator 	{printf("Declaracion de parametro.\n");}
	| declaration_specifiers 						{printf("Declaracion de parametro.\n");}
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER 				{printf("Lista de identificadores.\n");}
	;

type_name
	: specifier_qualifier_list
	| specifier_qualifier_list abstract_declarator 	{printf("Tipo de nombre.\n");}
	;

abstract_declarator
	: pointer
	| direct_abstract_declarator 					{printf("Declarador abstracto.\n");}
	| pointer direct_abstract_declarator 			{printf("Declarador abstracto.\n");}
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'
	| '[' ']' 														{printf("Declarador abstracto directo.\n");}
	| '[' constant_expression ']'            						{printf("Declarador abstracto directo.\n");}
	| direct_abstract_declarator '[' ']' 							{printf("Declarador abstracto directo.\n");}
	| direct_abstract_declarator '[' constant_expression ']' 		{printf("Declarador abstracto directo.\n");}
	| '(' ')' 														{printf("Declarador abstracto directo.\n");}
	| '(' parameter_type_list ')' 									{printf("Declarador abstracto directo.\n");}
	| direct_abstract_declarator '(' ')' 							{printf("Declarador abstracto directo.\n");}
	| direct_abstract_declarator '(' parameter_type_list ')' 		{printf("Declarador abstracto directo.\n");}
	;

initializer
	: assignment_expression
	| '{' initializer_list '}' 				{printf("Inicializador.\n");}
	| '{' initializer_list ',' '}' 			{printf("Inicializador.\n");}
	;

initializer_list
	: initializer 							{printf("Lista de inicializadores.\n");}
	| initializer_list ',' initializer 		{printf("Lista de inicializadores.\n");}
	;

statement
	: labeled_statement
	| compound_statement   					{printf("Declaracion.\n");}
	| expression_statement  				{printf("Declaracion.\n");}
	| selection_statement 					{printf("Declaracion.\n");}
	| iteration_statement					{printf("Declaracion.\n");}
	| jump_statement						{printf("Declaracion.\n");}
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement 	{printf("Declaracion.\n");}
	| DEFAULT ':' statement  					{printf("Declaracion.\n");}
	;

compound_statement
	: '{' '}'       							
	| '{' statement_list '}' 					{printf("Declaracion compuesta.\n");}
	| '{' declaration_list '}' 					{printf("Declaracion compuesta.\n");}
	| '{' declaration_list statement_list '}' 	{printf("Declaracion compuesta.\n");}
	;

declaration_list
	: declaration
	| declaration_list declaration 				{printf("Lista de declaraciones.\n");}
	;

statement_list
	: statement
	| statement_list statement 					{printf("Lista de declaraciones.\n");}
	;

expression_statement
	: ';'
	| expression ';' 							{printf("Declaracion de expresion.\n");}
	;

selection_statement
	: IF '(' expression ')' statement 					
	| IF '(' expression ')' statement ELSE statement 	{printf("Declaracion de seleccion.\n");}
	| SWITCH '(' expression ')' statement 				{printf("Declaracion de seleccion.\n");}
	;

iteration_statement
	: WHILE '(' expression ')' statement
	| DO statement WHILE '(' expression ')' ';' 									{printf("Declaracion de iteracion.\n");}
	| FOR '(' expression_statement expression_statement ')' statement 				{printf("Declaracion de iteracion.\n");}
	| FOR '(' expression_statement expression_statement expression ')' statement 	{printf("Declaracion de iteracion.\n");}
	; 

jump_statement
	: GOTO IDENTIFIER ';'		{printf("Declaracion de salto.\n");}
	| CONTINUE ';'				{printf("Declaracion de salto.\n");}
	| BREAK ';' 				{printf("Declaracion de salto.\n");}
	| RETURN ';'				{printf("Declaracion de salto.\n");}
	| RETURN expression ';'		{printf("Declaracion de salto.\n");}
	;

translation_unit
	: external_declaration 						
	| translation_unit external_declaration		{printf("Unidad de traduccion.\n");}
	;

external_declaration
	: function_definition
	| declaration 			{printf("Declaracion externa.\n");}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement
	| declaration_specifiers declarator compound_statement 						{printf("Definicion de funcion.\n");}
	| declarator declaration_list compound_statement 							{printf("Definicion de funcion.\n");}
	| declarator compound_statement 											{printf("Definicion de funcion.\n");}
	;

%%
