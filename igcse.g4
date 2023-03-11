grammar IGCSEPseudocode;

program : block EOF;

block: statement*;

statement
    : variable_declaration
    | constant_declaration
    | iterative_statement
    | conditional_statement
    | assignment_statement
    | input_statement
    | output_statement
    ;

type_specifier
    : Integer
    | Real
    | Boolen
    | Char
    | String
    ;

constant_declaration
    : Constant identifier Assign operand;
variable_declaration
    : Declare identifier Colon type_specifier
    | array_declaration
    ;

unsigned_const: PositiveIntegerConstant;
array_dimension
    : (unsigned_const Colon unsigned_const Comma?) array_dimension?
    ;
array_declaration
    : Declare identifier Colon
      Array
      LeftBracket array_dimension RightBracket
      Of type_specifier;
array_indexing
    : expression (Comma expression)*;
array_subscript
    : LeftBracket array_indexing RightBracket;
assignment_statement
    : identifier Assign expression;

input_statement
    : Input identifier;

output_statement
    : Output expression (Comma expression)*;

operand
    : identifier
    | constant
    | string
    ;
identifier: Identifier array_subscript?;
constant: ConstantValue;
string: StringLiteral;

unary_bitwise_operator
    : Complement;
multiplicative_operator
    : Multiply
    | Divide
    | Modulo
    ;
binary_bitwise_operator
    : BitwiseAnd
    | BitwiseOr
    | BitwiseXor
    | LeftShift
    | RightShift
    ;
additive_operator
    : Plus
    | Minus
    ;

expression
    : LeftParen expression RightParen
    | unary_bitwise_operator expression
    | expression multiplicative_operator expression
    | expression binary_bitwise_operator expression
    | expression additive_operator expression
    | operand
    ;

conditional_expression
    : LeftParen expression RightParen
    | unary_logical_operator conditional_expression
    | conditional_expression binary_logical_operator conditional_expression
    | expression comparator expression
    ;

unary_logical_operator
    : LogicalNot;
binary_logical_operator
    : LogicalAnd
    | LogicalOr
    ;

comparator
    : Less
    | LessEqual
    | Greater
    | GreaterEqual
    | Equal
    ;

iterative_statement
    : for_statement
    | while_statement
    | repeat_statement
    ;

for_statement
    : For identifier Assign operand To operand (Step operand)?
      block
      Next identifier?;

while_statement
    : While conditional_expression Do
      block
      EndWhile;

repeat_statement
    : Repeat
      block
      Until conditional_expression;

conditional_statement
    : if_statement
    | case_statement
    ;

if_statement
    : If conditional_expression
      Then
      block
      (Else
      block)?
      EndIf;

case_statement
    : Case Of identifier
      case_condition
      EndCase;
case_condition
    : Constant Colon statement
      case_condition*
    | Otherwise statement
      case_condition*
    ;

LeftParen : '(';
RightParen : ')';
LeftBracket : '[';
RightBracket : ']';
LeftBrace : '{';
RightBrace : '}';
Comma : ',';
Colon : ':';

Assign : '←' | '<-';

Less : '<';
LessEqual : '<=';
Greater : '>';
GreaterEqual : '>=';
Equal : '=';
LeftShift : '<<';
RightShift : '>>';

Plus : '+';
PlusPlus : '++';
Minus : '-';
MinusMinus : '--';
Multiply : '*';
Divide : '/';
Modulo : '%';

BitwiseAnd : '&';
BitwiseOr : '|';
BitwiseXor : '^';
Complement : '~';

LogicalAnd : 'AND';
LogicalOr : 'OR';
LogicalNot : 'NOT';

Integer : 'INTEGER';
Real : 'REAL';
Boolen : 'BOOLEAN';
Char : 'CHAR';
String : 'STRING';

Declare : 'DECLARE';
Constant : 'CONSTANT';
Array : 'ARRAY';
Input : 'INPUT';
Output : 'OUTPUT';
If : 'IF';
Then : 'THEN';
Else : 'ELSE';
EndIf : 'ENDIF';
Case : 'CASE';
Of : 'OF';
Otherwise : 'OTHERWISE';
EndCase : 'ENDCASE';
For : 'FOR';
To : 'TO';
Step : 'STEP';
Next : 'NEXT';
Do : 'DO';
EndFor : 'ENDFOR';
Repeat : 'REPEAT';
Until : 'UNTIL';
While : 'WHILE';
EndWhile : 'ENDWHILE';
Function : 'FUNCTION';
Returns : 'RETURNS';
Return : 'RETURN';
EndFunction : 'ENDFUNCTION';
Procedure : 'PROCEDURE';
EndProcedure : 'ENDPROCEDURE';
Call : 'CALL';
True : 'TRUE';
False : 'FALSE';

fragment
Nondigit
    : [a-zA-Z]
    ;
fragment
Digit
    : [0-9]
    ;
fragment
NonzeroDigit
    : [1-9]
    ;
fragment
OctalDigit
    : [0-7]
    ;
fragment
HexadecimalDigit
    : [0-9a-fA-F]
    ;

Identifier
    : Nondigit (Nondigit | Digit)*
    ;

ConstantValue
    : Sign? PositiveConstantValue;
PositiveConstantValue
    : PositiveIntegerConstant
    | FloatingConstant
    | CharacterConstant
    | BooleanConstant
    ;
BooleanConstant
    : True
    | False
    ;
PositiveIntegerConstant
    : DecimalConstant
    | OctalConstant
    | HexadecimalConstant
    |	BinaryConstant
    ;

fragment
BinaryConstant
    : '0' [bB] [0-1]+
    ;
fragment
DecimalConstant
    : NonzeroDigit Digit*
    ;
fragment
OctalConstant
    : '0' OctalDigit*
    ;
fragment
HexadecimalConstant
    : '0' [xX] HexadecimalDigit+
    ;

fragment
FloatingConstant
    : FractionalConstant ExponentPart?
    | DigitSequence ExponentPart
    ;
fragment
FractionalConstant
    : DigitSequence? '.' DigitSequence
    | DigitSequence '.'
    ;
fragment
ExponentPart
    : [eE] Sign? DigitSequence
    ;

fragment
Sign
    : [+-]
    ;

DigitSequence
    : Digit+
    ;

fragment
EscapeSequence
    : '\\' ['"?abfnrtv\\]
    ;

fragment
CharacterConstant
    : '\'' CharacterElement+ '\''
    ;
fragment
CharacterElement
    : ~['\\\r\n]
    | EscapeSequence
    ;

StringLiteral
    : '"' StringElement+ '"'
    ;
fragment
StringElement
    : ~["\\\r\n]
    | EscapeSequence
    ;

Whitespace
    : [ \t]+
      -> skip
    ;
Newline
    : [\r\n]+
      -> channel(HIDDEN)
    ;
LineComment
    : '//' ~[\r\n]*
      -> skip
    ;
