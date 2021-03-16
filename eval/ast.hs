module AST where

import Tokenizer

data UnaryOp = UnaryPlus | UnaryMinus
data BinaryOp = Add | Sub | Mul | Div
data EvalTree = ValueNode Integer 
              | UnaryOpNode UnaryOp EvalTree 
              | BinaryOpNode BinaryOp EvalTree EvalTree
              deriving Show

buildTree :: [Token] -> Maybe EvalTree
buildTree [] = Nothing 