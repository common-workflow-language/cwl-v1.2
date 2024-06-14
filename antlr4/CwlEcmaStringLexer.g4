lexer grammar CwlEcmaStringLexer;

ANYCHAR: .;
DOLLARPAREN: '$(' -> pushMode(ParenExpr);
LPAREN: '(';
RPAREN: ')';
DOLLARBRACE: '${' -> pushMode(BraceExpr);
LBRACE: '{';
RBRACE: '}';
DOLLARPARENESC: '\\$(';
DOLLARBRACEESC: '\\${';
BACKSLASH: '\\';
BACKSLASHESC: '\\\\';

mode ParenExpr;

EscPart: BACKSLASH ANYCHAR;
SubExprStart: LPAREN -> pushMode(SubExpr);
ExprEnd: RPAREN -> popMode;
ExprPart: ~[)];

mode SubExpr;

SubEscPart: BACKSLASH ANYCHAR -> type(SubExprPart);
SubSubExprStart: LPAREN -> pushMode(SubExpr);
SubExprEnd: RPAREN -> popMode;
SubExprPart: ~[)];

mode BraceExpr;

BraceEscPart: BACKSLASH ANYCHAR -> type(EscPart);
BraceSubExprStart: LBRACE -> pushMode(BraceSubExpr), type(SubExprStart);
BraceExprEnd: RBRACE -> popMode, type(ExprEnd);
BraceExprPart: ~[}] -> type(ExprPart);

mode BraceSubExpr;

BraceSubEscPart: BACKSLASH ANYCHAR -> type(SubExprPart);
BraceSubSubExprStart: LBRACE -> pushMode(BraceSubExpr), type(SubSubExprStart);
BraceSubExprEnd: RBRACE -> popMode, type(SubExprEnd);
BraceSubExprPart: ~[}] -> type(SubExprPart);