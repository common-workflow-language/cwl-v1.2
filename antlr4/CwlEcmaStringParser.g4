parser grammar CwlEcmaStringParser;

options {
  tokenVocab=CwlEcmaStringLexer;
}

sub_sub_expr
  : SubSubExprStart sub_expr_part* SubExprEnd
  ;

sub_expr_part
  : SubExprPart
  | sub_sub_expr
  ;

sub_expr
  : SubExprStart sub_expr_part* SubExprEnd
  ;

expr_part
  : ExprPart
  | EscPart
  | sub_expr
  ;

paren_expr
  : DOLLARPAREN expr_part+ ExprEnd
  ;

brace_expr
  : DOLLARBRACE expr_part+ ExprEnd
  ;

interpolated_string_part
  : BACKSLASHESC
  | DOLLARPARENESC
  | DOLLARBRACEESC
  | paren_expr
  | brace_expr
  | ANYCHAR
  ;

interpolated_string
  : interpolated_string_part+
  ;