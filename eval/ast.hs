module AST where

import Text.Show
import Tokenizer
import Data.List ( uncons )

-- expr -> expr + term | expr - term | term
-- term -> term * factor | term / factor | factor
-- factor -> value | (expr)

data UnaryOp = UnaryPlus | UnaryMinus
    deriving Show

data BinaryOp = Add | Sub | Mul | Div
    deriving Show

data EvalTree = ValueNode Integer
              | UnaryOpNode UnaryOp EvalTree
              | BinaryOpNode BinaryOp EvalTree EvalTree
              deriving Show


isPlusMinus :: Token -> Bool
isPlusMinus (ArithmeticToken Plus) = True
isPlusMinus (ArithmeticToken Minus) = True
isPlusMinus _ = False


isStarSlash :: Token -> Bool
isStarSlash (ArithmeticToken Star) = True
isStarSlash (ArithmeticToken Slash) = True
isStarSlash _ = False


unaryOp :: ArithmeticSign  -> UnaryOp
unaryOp Plus = UnaryPlus
unaryOp Minus = UnaryMinus


binaryOp :: ArithmeticSign -> BinaryOp
binaryOp Plus = Add
binaryOp Minus = Sub
binaryOp Star = Mul
binaryOp Slash = Div


makeBinary :: Token -> EvalTree -> EvalTree -> EvalTree
makeBinary (ArithmeticToken sign) = BinaryOpNode (binaryOp sign)


splitBySign :: (Token -> Bool) -> ([Token] -> EvalTree) -> ([Token] -> EvalTree) -> [Token] -> EvalTree
splitBySign signPred leftFunc rightFunc tokens = 
    let lastAndRest = break signPred . reverse $ tokens
        lst = reverse. fst $ lastAndRest
        rst = snd lastAndRest
    in case rst of 
        [] -> rightFunc lst
        _ -> BinaryOpNode (binaryOp sign) leftSplit rightSplit
            where
                (ArithmeticToken sign) = head rst
                rightSplit = rightFunc lst
                extract [] = error "Unexpected sign token without parameter."
                extract leftTokens = leftFunc . init . reverse $ leftTokens
                leftSplit = extract rst 


-- expr -> expr + term | expr - term | term
splitExpr :: [Token] -> EvalTree
splitExpr = splitBySign isPlusMinus exprTree termTree

exprTree :: [Token] -> EvalTree
exprTree [a] = termTree [a]
exprTree tokens = splitExpr tokens


-- term -> term * factor | term / factor | factor
splitTerm :: [Token] -> EvalTree
splitTerm = splitBySign isStarSlash termTree factorTree

termTree :: [Token] -> EvalTree
termTree [a] = factorTree [a]
termTree tokens = splitTerm tokens


factorTree :: [Token] -> EvalTree
factorTree [ValueToken value] = ValueNode value


buildTree :: [Token] -> Maybe EvalTree
buildTree [] = Nothing
buildTree tokens = Just . exprTree $ tokens
