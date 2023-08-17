module DivStructModule (
    Div
    , defaultDiv
    , isDefault
    , isImage
    , src
    , width
    , height
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
    , getWidth
    , getHeight
    , getOutSpace
    , getOutJump
    , getInSpace
    , getInJump
    , getColor
    , getSrc
    ) 
where
import Text.Read (readMaybe)
import Debug.Trace

-- my modules
import ColorsModule
import UtilModule
-- represents div and all its attributes
data Div = Div 
    { isDefault :: Bool
    , isImage :: Bool
    , src :: String
    , width :: String
    , height :: String
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

-- woks as base if no style is defined
defaultDiv :: Div
defaultDiv = Div 
    { isDefault = True
    , isImage = False
    , src = ""
    , width = "100px"
    , height = "100px"
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

-- these return requested valued from style part of line
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

getWidth :: String -> String
getWidth input = case dropWhile (/= "width") (words input) of
    ("width" : widthValue : _) -> widthValue
    _ -> "auto"

getHeight :: String -> String
getHeight input = case dropWhile (/= "height") (words input) of
    ("height" : heightValue : _) -> heightValue
    _ -> "auto"


getSrc :: String -> String
getSrc input = trace ("traced: \"" ++ input ++ "\"") (case dropWhile (/= "src") (words input) of
    ("src" : srcValue : _) -> srcValue
    _ -> "")

getColor :: String -> Char -> String -> Int 
getColor _ channel _
    | channel /= 'r' && channel /= 'g' && channel /= 'b' = 0
getColor input channel finding = case dropWhile (/= finding) (words input) of
    -- check for f g b
    (finding : red : green : blue : _) 
        | all isNumber [red, green, blue] && elem channel "rgb" -> maybe 0 id (readMaybe (getColorRGB channel [red, green, blue]))
    -- check for color like "black" or "red"
    (finding : color : _) -> floor $ colorMap color channel
    _ -> 0
