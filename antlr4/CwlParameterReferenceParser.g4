parser grammar CwlParameterReferenceParser;

options {
  tokenVocab=CwlParameterReferenceLexer;
}

expr_dot_symbol
  : ExprDot ExprSymbol
  ;

int_index
  : ExprIntIndex IntIndexPart ExprIntIndex
  ;

string_index_part
  : StringIndexPart
  | StringIndexEscPart
  ;

string_index
  : ExprSingleQ string_index_part+ ExprSingleQ
  | ExprDoubleQ string_index_part+ ExprDoubleQ
  ;

expr_segment
  : expr_dot_symbol
  | int_index
  | string_index
  ;

paren_expr
  : DOLLARPAREN ExprSymbol expr_segment* EndParenExpr
  ;

interpolated_string_part
  : BACKSLASHESC
  | DOLLARPARENESC
  | paren_expr
  | ANYCHAR
  ;

interpolated_string
  : interpolated_string_part+
  ;