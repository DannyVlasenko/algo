module AST where

import Tokenizer

-- expr -> expr + term | expr - term | term
-- term -> term * factor | term / factor | factor
-- factor -> value | (expr)

data UnaryOp = UnaryPlus | UnaryMinus
data BinaryOp = Add | Sub | Mul | Div
data EvalTree = ValueNode Integer 
              | UnaryOpNode UnaryOp EvalTree 
              | BinaryOpNode BinaryOp EvalTree EvalTree
              deriving Show


isPlusMinus :: Token -> Boolean
isPlusMinus (ArithmeticToken Plus) = True 
isPlusMinus (ArithmeticToken Minus) = True 
isPlusMinus _ = False 


unaryOp :: ArithmeticToken -> UnaryOp
unaryOp (ArithmeticSign Plus) = UnaryPlus
unaryOp (ArithmeticSign Minus) = UnaryMinus


binaryOp :: ArithmeticToken -> BinaryOp
binaryOp (ArithmeticSign Plus) = Add
binaryOp (ArithmeticSign Minus) = Sub
binaryOp (ArithmeticSign Star) = Mul
binaryOp (ArithmeticSign Slash) = Div


makeNode :: Maybe ArithmeticToken -> Maybe EvalTree -> Maybe EvalTree -> Maybe EvalTree
makeNode Nothing Nothing Nothing = Nothing
makeNode Nothing _ _ = error "Unexpected expression tokens without operation sign."
makeNode (ArithmeticSign sign) (Just left) Nothing = UnaryOpNode (unaryOp sign) left
makeNode (ArithmeticSign sign) Nothing (Just right) = UnaryOpNode (unaryOp sign) right
makeNode (ArithmeticSign sign) (Just left) (Just right) = BinaryOpNode (binaryOp sign) left right


factor :: [Token] -> Maybe EvalTree
factor [] = Nothing
factor [ValueToken value] = ValueNode value


term :: [Token] -> Maybe EvalTree
term [] = Nothing
term [a] = factor a
term tokens = 

expr :: [Token] -> Maybe EvalTree
expr [] = Nothing
expr tokens = makeNode sign (term firstTerm) restExpr 
    where
        firstAndRest = span (not . isPlusMinus) tokens
        firstTerm = fst firstAndRest
        rest = snd firstAndRest
        signAndExpr = uncons rest
        sign = signAndExpr >>= fst
        restExpr = signAndExpr >>= snd >>= expr     


applyUnary :: UnaryOp -> Integer -> Integer
applyUnary UnaryPlus a = a
applyUnary UnaryMinus a = negate a


applyBinary :: BinaryOp -> Integer -> Integer -> Integer
applyBinary Add a b = a + b
applyBinary Sub a b = a - b
applyBinary Mul a b = a * b
applyBinary Div a b = div a b


eval :: EvalTree -> Integer
eval (ValueNode val) = val
eval (UnaryOpNode op child) = applyUnary op . eval $ child
eval (BinaryOpNode op left right) = applyBinary op (eval left) (eval right)