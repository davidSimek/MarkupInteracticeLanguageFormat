module TokenizerModule (tokenize, Div, toTag) where

data Div = Div 
    { isDefault :: Bool
    , content :: String
    , font :: String

    , br :: Int  ---------------
    , bg :: Int  -- BG colors -- 
    , bb :: Int  ---------------
    , ba :: Float

    , fr :: Int  ---------------
    , fg :: Int  -- FG colors --  
    , fb :: Int  ---------------
    , fa :: Float

    , margin :: Int
    , marginUnit :: String
    , padding :: Int
    , paddingUnit :: String
    }


toTag :: Div -> String
toTag div = "<div style=\"background-color: rgba(" ++ show (br div) ++ ", " ++ show (bg div) ++ ", " ++ show (bb div) ++ ", " ++ show (ba div) ++ "); color: rgba(" ++ show (fr div) ++ ", " ++ show (fg div) ++ ", " ++ show (fb div) ++ " ," ++ show (fa div) ++ "); margin: " ++ show (margin div) ++ marginUnit div ++ "; padding: " ++ show (padding div) ++ paddingUnit div ++ ";\">" ++ content div ++ "</div>\n"

errorDiv :: Div
errorDiv = Div 
    { isDefault = False
    , content = "hello"
    , font = "13px Arial, sans-serif"

    , br =   0  ---------------
    , bg =   0  -- BG colors -- 
    , bb =   0  ---------------
    , ba = 0.0

    , fr =   0  ---------------
    , fg =   0  -- FG colors --  
    , fb =   0  ---------------
    , fa =   1.0

    , margin = 0
    , marginUnit = "px"
    , padding = 20
    , paddingUnit = "px"
    }


defaultDiv :: Div
defaultDiv = Div 
    { isDefault = True
    , content = ""
    , font = "0px Arial, sans-serif"

    , br =   0 ---------------
    , bg =   0  -- BG colors -- 
    , bb =   0 ---------------
    , ba = 0.0

    , fr =   0  ---------------
    , fg =   0  -- FG colors --  
    , fb =   0  ---------------
    , fa = 0.0

    , margin = 0
    , marginUnit = "px"
    , padding = 0
    , paddingUnit = "px"
    }



tokenize :: String -> [Div]
tokenize [] = [errorDiv] 
tokenize code = parseLogic (lines code)

parseLogic :: [String] -> [Div]
parseLogic [] = [errorDiv]
parseLogic lines = keepDivs (map parse lines)

parse :: String -> Div
parse [] = defaultDiv
parse line = produceDiv (separateContent line)
    where
        -- " and # are considered illegal for now
        -- - commint -> ["comment", "", ""]
        -- "this is text" lalala lalala -> ["div", "this is text", "lalala"] 
        -- #colorText# font-size 20 font-color red -> ["style", "colorText", "font-size 20 font-color red"]
        --
        --
        separateContent :: String -> [String]
        separateContent line
            | getType line == "div" = ["div"] ++ splitOnN line (findNth line '\"' 2 0 0) 0
            | getType line == "style" = ["style"] ++ splitOnN line (findNth line '#' 2 0 0) 0 
            | getType line == "comment" = ["comment", "", ""]

        findNth :: String -> Char -> Int -> Int -> Int
        findNth [] _ _ _ currentIndex = currentIndex
        findNth (char:rest) finding n foundCount currentIndex
            | char == finding && foundCount + 1 == n = currentIndex
            | char == finding = findNth rest finding n (foundCount + 1) (currentIndex + 1)
            | otherwise = findNth rest finding n foundCount (currentIndex + 1)


        -- make this work on empty chars on start of line it future
        getType :: String -> String
        getType (char:rest)
            | char == '"' = "div"
            | char == '#' = "style"
            | otherwise = "comment"

        splitOnN :: String -> Int -> [String]
        splitOnN line index = [take index line, drop index line]

produceDiv :: [String] -> Div
produceDiv (first:rest)
    | first == "comment" = defaultDiv
    | first == "class" = defaultDiv
    | otherwise = defaultDiv

keepDivs :: [Div] -> [Div]
keepDivs [] = []
keepDivs (div:rest)
    | isDefault div = keepDivs rest
    | otherwise = div : keepDivs rest
