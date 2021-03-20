import AST
import Tokenizer
import Data.List ( uncons )


applyUnary :: UnaryOp -> Integer -> Integer
applyUnary UnaryPlus a = a
applyUnary UnaryMinus a = negate a


applyBinary :: BinaryOp -> Integer -> Integer -> Integer
applyBinary Add a b = a + b
applyBinary Sub a b = a - b
applyBinary Mul a b = a * b
applyBinary Div a b = div a b


evalTree :: EvalTree -> Integer
evalTree (ValueNode val) = val
evalTree (UnaryOpNode op child) = applyUnary op . evalTree $ child
evalTree (BinaryOpNode op left right) = applyBinary op (evalTree left) (evalTree right)


eval :: String -> Maybe Integer
eval expression = (buildTree . tokenize) expression >>= Just . evalTree
