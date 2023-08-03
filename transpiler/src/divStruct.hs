module DivStructModule (
    Div
    , defaultDiv
    , isDefault
    , content
    , font
    , fontSize
    , br
    , bg
    , bb
    , ba
    , fr
    , fg
    , fb
    , fa
    , outSpace
    , outJump
    , inSpace
    , inJump
    , style

    , getFont
    , getFontSize
    , getStyle
    , getOutSpace
    , getOutJump
    , getInSpace
    , getInJump
    ) 
where

data Div = Div 
    { isDefault :: Bool
    , content :: String
    , font :: String
    , fontSize :: String

    , br :: Int  ---------------
    , bg :: Int  -- BG colors -- 
    , bb :: Int  ---------------
    , ba :: Float

    , fr :: Int  ---------------
    , fg :: Int  -- FG colors --  
    , fb :: Int  ---------------
    , fa :: Float

    , outSpace :: String
    , outJump :: String
    , inSpace :: String
    , inJump :: String

    -- internal
    , style :: String
    } deriving (Show)

defaultDiv :: Div
defaultDiv = Div 
    { isDefault = True
    , content = "default"
    , font = "Arial, sans-serif"
    , fontSize = "15px"

    , br =   0 ---------------
    , bg =   0  -- BG colors -- 
    , bb =   0 ---------------
    , ba = 0.0

    , fr =   0  ---------------
    , fg =   0  -- FG colors --  
    , fb =   0  ---------------
    , fa = 1.0

    , outSpace = "0px"
    , outJump = "0px"
    , inSpace = "10px"
    , inJump = "10px"
    , style = ""
    }

getOutSpace :: String -> String
getOutSpace input = case dropWhile (/= "outSpace") (words input) of
    ("outSpace" : outSpaceValue : _) -> outSpaceValue
    _ -> "0px"

getOutJump :: String -> String
getOutJump input = case dropWhile (/= "outJump") (words input) of
    ("outJump" : outJumpValue : _) -> outJumpValue
    _ -> "0px"

getInSpace :: String -> String
getInSpace input = case dropWhile (/= "inSpace") (words input) of
    ("inSpace" : inSpaceValue : _) -> inSpaceValue
    _ -> "0px"

getInJump :: String -> String
getInJump input = case dropWhile (/= "inJump") (words input) of
    ("inJump" : inJumpValue : _) -> inJumpValue
    _ -> "10px"

getStyle :: [String] -> String
getStyle (input:_) = case dropWhile (/= "style") (words input) of
    ("style" : styleValue : _) -> styleValue
    _ -> "default"

getFont :: String -> String
getFont input = case dropWhile (/= "font") (words input) of
    ("font" : fontValue : _) -> fontValue
    _ -> "Arial, sans-serif"

getFontSize :: String -> String
getFontSize input = case dropWhile (/= "fontSize") (words input) of
    ("fontSize" : fontSizeValue : _) -> fontSizeValue
    _ -> "15px"


