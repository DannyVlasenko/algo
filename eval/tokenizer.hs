import Data.List ()
import Data.Char ( isDigit, isSpace )
import Text.Read ( readMaybe )

data ArithSign = Plus | Minus | Star | Slash
    deriving Show

data Token = Value Integer | Arithmetic ArithSign | ParLeft | ParRight
    deriving Show

tokenize :: String -> [Token]
tokenize s = tokenizeValue valStr ++ tokenizeSymbols symStr where
    spanStr = span isDigit s
    valStr = fst spanStr
    symStr = snd spanStr
    tokenizeValue :: String -> [Token]
    tokenizeValue [] = []
    tokenizeValue digits = [Value (read digits :: Integer)]
    tokenizeSymbols :: String -> [Token]
    tokenizeSymbols [] = []
    tokenizeSymbols [' '] = []
    tokenizeSymbols ['+'] = [Arithmetic Plus]
    tokenizeSymbols ['-'] = [Arithmetic Minus]
    tokenizeSymbols ['*'] = [Arithmetic Star]
    tokenizeSymbols ['/'] = [Arithmetic Slash]
    tokenizeSymbols ['('] = [ParLeft]
    tokenizeSymbols [')'] = [ParRight]
    tokenizeSymbols [unknown]
        | isSpace unknown = []
        | otherwise = error $ "Invalid token " ++ [unknown]
    tokenizeSymbols (x:xs)
        | isSpace x = tokenize xs
        | otherwise = tokenizeSymbols [x] ++ tokenize xs
