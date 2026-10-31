lexer grammar CwlParameterReferenceLexer;

DOT: '.';
LBRACKET: '[';
RBRACKET: ']';
DOLLARPAREN: '$(' -> pushMode(ParenExpr);
RPAREN: ')';
DOLLARPARENESC: '\\$(';
BACKSLASH: '\\';
BACKSLASHESC: '\\\\';
ANYCHAR: .;
LBRACKETSINGLEQ: '[\'';
LBRACKETDOUBLEQ: '["';
SINGLEQRBRACKET: '\']';
DOUBLEQRBRACKET: '"]';

mode ParenExpr;

ExprDot: DOT;
ExprSymbol: CompleteSymbol;
ExprSingleQ: LBRACKETSINGLEQ -> pushMode(SingleQString);
ExprDoubleQ: LBRACKETDOUBLEQ -> pushMode(DoubleQString);
ExprIntIndex: LBRACKET -> pushMode(IntIndex);
EndParenExpr: RPAREN -> popMode;

mode SingleQString;

StringIndexEscPart: BACKSLASH ANYCHAR;
EndSingleQ: SINGLEQRBRACKET -> popMode, type(ExprSingleQ);
StringIndexPart: ~[\\']+;
LiteralBackslash: BACKSLASH -> type(StringIndexPart);

mode DoubleQString;

DoubleQEscapedChar: BACKSLASH ANYCHAR -> type(StringIndexEscPart);
EndDoubleQ: DOUBLEQRBRACKET ->  popMode, type(ExprDoubleQ);
DoubleQStringIndexPart: ~[\\"]+ -> type(StringIndexPart);
DoubleQLiteralBackslash: BACKSLASH -> type(StringIndexPart);

mode IntIndex;

EndIndex: RBRACKET -> popMode, type(ExprIntIndex);
IntIndexPart: DecimalNumber;

fragment CompleteSymbol
	: SymbolStart SymbolFollow*
	;

fragment SymbolStart
	: [a-zA-Z]
	;

fragment SymbolFollow
	: [a-zA-Z0-9_]+
	;

fragment DecimalNumber
  : DecimalDigit+
  ;

fragment DecimalDigit
  : [0-9]
  ;

fragment HexDigit
	: [0-9a-fA-F]
	;
