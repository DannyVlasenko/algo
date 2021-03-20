module Tokenizer where

import Data.List ()
import Data.Char ( isDigit, isSpace )
import Text.Read ( readMaybe )

data ArithmeticSign = Plus | Minus | Star | Slash
    deriving Show

data Token = ValueToken Integer 
           | ArithmeticToken ArithmeticSign 
           | ParenthesisLeft 
           | ParenthesisRight
           deriving Show


tokenizeValue :: String -> [Token]
tokenizeValue [] = []
tokenizeValue digits = [ValueToken (read digits :: Integer)]


tokenizeSymbols :: String -> [Token]
tokenizeSymbols [] = []
tokenizeSymbols [' '] = []
tokenizeSymbols ['+'] = [ArithmeticToken Plus]
tokenizeSymbols ['-'] = [ArithmeticToken Minus]
tokenizeSymbols ['*'] = [ArithmeticToken Star]
tokenizeSymbols ['/'] = [ArithmeticToken Slash]
tokenizeSymbols ['('] = [ParenthesisLeft]
tokenizeSymbols [')'] = [ParenthesisRight]
tokenizeSymbols [unknown]
    | isSpace unknown = []
    | otherwise = error $ "Invalid token " ++ [unknown]
tokenizeSymbols (x:xs)
    | isSpace x = tokenize xs
    | otherwise = tokenizeSymbols [x] ++ tokenize xs


tokenize :: String -> [Token]
tokenize s = tokenizeValue valueStr ++ tokenizeSymbols symbolicStr where
    spanStr = span isDigit s
    valueStr = fst spanStr
    symbolicStr = snd spanStr