import AST

applyBinary :: BinaryOp -> Integer -> Integer -> Integer
applyBinary Add a b = a + b
applyBinary Sub a b = a - b
applyBinary Mul a b = a * b
applyBinary Div a b = div a b

applyUnary :: UnaryOp -> Integer -> Integer
applyUnary UnaryPlus a = a
applyUnary UnaryMinus a = negate a