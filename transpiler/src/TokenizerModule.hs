module TokenizerModule (keepDivs, makeDivs, Div, toTag) where

import Text.Read (readMaybe)
import Debug.Trace

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

    , margin :: String
    , padding :: String

    -- internal
    , style :: String
    } deriving (Show)


toTag :: Div -> String
toTag div = "<div style=\"background-color: rgba(" ++ show (br div) ++ ", " ++ show (bg div) ++ ", " ++ show (bb div) ++ ", " ++ show (ba div) ++ "); color: rgba(" ++ show (fr div) ++ ", " ++ show (fg div) ++ ", " ++ show (fb div) ++ ", " ++ show (fa div) ++ "); margin: " ++ margin div ++ "; padding: " ++ padding div ++ ";\">" ++ content div ++ "</div>\n"


defaultDiv :: Div
defaultDiv = Div 
    { isDefault = True
    , content = "default"
    , font = "0px Arial, sans-serif"

    , br =   0 ---------------
    , bg =   0  -- BG colors -- 
    , bb =   0 ---------------
    , ba = 0.0

    , fr =   0  ---------------
    , fg =   0  -- FG colors --  
    , fb =   0  ---------------
    , fa = 1.0

    , margin = "0px"
    , padding = "10px"
    , style = ""
    }

makeDivs :: [String] -> [Div] -> [Div]
makeDivs [] _ = [defaultDiv { content = "end of document" }] 
makeDivs (line:rest) styles
    -- | getType line == "style" = ((parse line styles) : (makeDivs rest (parse line styles : styles)))
    | getType line == "div" || getType line == "style" = (parse line styles: makeDivs rest (parse line styles : styles))
    | getType line == "comment" = makeDivs rest styles

--                 defStyles
parse :: String -> [Div] ->    Div
parse [] _ = defaultDiv { content = "problem in parse function" }
parse line styles =  produceDiv (separateContent line) styles

separateContent :: String -> [String]
separateContent [] = ["comment", "", ""]
separateContent line
    | getType line == "div"   = ["div"]   ++ splitOnN line (findSecDoub line 0 0)
    | getType line == "style" = ["style"] ++ splitOnN line (findSecHash line 0 0) 
    | getType line == "comment" = ["comment", "", ""]
    | otherwise = ["comment", "", ""]

splitOnN :: String -> Int -> [String]
splitOnN (first:line) index = [take (index - 1) line, drop index line]

getType :: String -> String
getType [] = []
getType (char:rest)
    | char == '"' = "div"
    -- | char == '#' = "style"
    | char == '#' = "style"
    | char == '-' = "comment"
    | char == ' ' = getType rest
    | otherwise = "comment"


findSecDoub :: String -> Int -> Int -> Int
findSecDoub [] _ currentIndex = currentIndex
findSecDoub (char:rest) foundCount currentIndex
    | char == '"' && foundCount + 1 == 2 = currentIndex
    | char == '"' = findSecDoub rest (foundCount + 1) (currentIndex + 1)
    | otherwise = findSecDoub rest foundCount (currentIndex + 1)

findSecHash :: String -> Int -> Int -> Int
findSecHash [] _ currentIndex = currentIndex
findSecHash (char:rest) foundCount currentIndex
    | char == '#' && foundCount + 1 == 2 = currentIndex
    | char == '#' = findSecHash rest (foundCount + 1) (currentIndex + 1)
    | otherwise = findSecHash rest foundCount (currentIndex + 1)



isNumber :: String -> Bool
isNumber str = case readMaybe str :: Maybe Double of
  Just _ -> True
  Nothing -> False

--                        styles library
produceDiv :: [String] -> [Div]            -> Div
produceDiv (first:parsedContent:parsedStyle) styles
    -- | first == "div"   = styleDiv parsedContent parsedStyle (findStyle styles parsedContent) 
    | first == "div"   = styleDiv parsedContent parsedStyle (findStyle styles (getStyle parsedStyle))
    -- | first == "style" = trace (show $ findStyle styles  parsedContent) styleDiv parsedContent parsedStyle (findStyle styles parsedContent)
    | first == "style" =  styleDiv parsedContent parsedStyle (findStyle styles (getStyle parsedStyle))
    | first == "comment" = defaultDiv { content = "comment" }
    | otherwise = defaultDiv { content = "comment without --" }
        where
            --          content   style       predStyle
            styleDiv :: String -> [String] -> Div ->    Div
            styleDiv _ [] _ = defaultDiv
            styleDiv parsedContent (style:_) baseStyle = baseStyle {
                isDefault = False,
                content = parsedContent,
                padding = if padding baseStyle /= padding defaultDiv then padding baseStyle else getPadding style,
                margin = if margin baseStyle /= margin defaultDiv then margin baseStyle else getMargin style,
                br = if br baseStyle /= br defaultDiv then br baseStyle else getColor style 'r' "bg",
                bg = if bg baseStyle /= bg defaultDiv then bg baseStyle else getColor style 'g' "bg",
                bb = if bb baseStyle /= bb defaultDiv then bb baseStyle else getColor style 'b' "bg",
                ba = if ba baseStyle /= ba defaultDiv then ba baseStyle else getBgAlpha style "bg",

                fr = if fr baseStyle /= fr defaultDiv then fr baseStyle else getColor style 'r' "color",
                fg = if fg baseStyle /= fg defaultDiv then fg baseStyle else getColor style 'g' "color",
                fb = if fb baseStyle /= fb defaultDiv then fb baseStyle else getColor style 'b' "color",
                fa = if fa baseStyle /= fa defaultDiv then fa baseStyle else getFgAlpha style "color"
            }

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

            readMaybe :: String -> Maybe Int
            readMaybe s = case reads s of
                [(x, "")] -> Just x 
                _         -> Nothing
        
findStyle :: [Div] -> String -> Div
findStyle [] styleString = defaultDiv { content = ("didn't find style" ++ styleString) }
findStyle (div:rest) nameOfStyle
    | content div == nameOfStyle = div
    | otherwise = findStyle rest nameOfStyle

getColorRGB :: Char -> [String] -> String
getColorRGB 'r' (r : _ : _) = r
getColorRGB 'g' (_ : g : _) = g
getColorRGB 'b' (_ : _ : b : _) = b
getColorRGB _ _ = "0"

getFgAlpha :: String -> String -> Float
getFgAlpha input finding = case dropWhile (/= finding) (words input) of
    (finding : r : g : b : a : _)
        | all isNumber [r, g, b, a] -> read a
    (finding : color : _) -> colorMap color 'a'
    _ -> 1.0 

getBgAlpha :: String -> String -> Float
getBgAlpha input finding = case dropWhile (/= finding) (words input) of
    (finding : r : g : b : a : _)
        | all isNumber [r, g, b, a] -> read a
    (finding : color : _) -> colorMap color 'a'
    _ -> 0.0 

getMargin :: String -> String
getMargin input = case dropWhile (/= "margin") (words input) of
    ("margin" : marginValue : _) -> marginValue
    _ -> "0px"

getPadding :: String -> String
getPadding input = case dropWhile (/= "padding") (words input) of
    ("padding" : paddingValue : _) -> paddingValue
    _ -> "0px"

getStyle :: [String] -> String
getStyle (input:_) = case dropWhile (/= "style") (words input) of
    ("style" : styleValue : _) -> styleValue
    _ -> "default"



--          color     r|g|b 
colorMap :: String -> Char -> Float 
colorMap [] 'a' = 1.0
colorMap [] _ = 0.0
colorMap color 'r'
    | color == "black" = 0.0
    | color == "white" = 255.0
    | color == "red" = 255.0
    | color == "green" = 0.0
    | color == "blue" = 0.0
    | color == "transparent" = 0.0
    | otherwise = 255.0
colorMap color 'g'
    | color == "black" = 0.0
    | color == "white" = 255.0
    | color == "red" = 0.0
    | color == "green" = 255.0
    | color == "blue" = 0.0
    | color == "transparent" = 0.0
    | otherwise = 255.0
colorMap color 'b'
    | color == "black" = 0.0
    | color == "white" = 0.0
    | color == "red" = 0.0
    | color == "green" = 0.0
    | color == "blue" = 255.0
    | color == "transparent" = 0.0
    | otherwise = 255.0
colorMap color 'a'
    | color == "black" = 1.0
    | color == "white" = 1.0
    | color == "red" = 1.0
    | color == "green" = 1.0
    | color == "blue" = 1.0
    | color == "transparent" = 0.0
    | otherwise = 0.0
colorMap _ _ = 0.0

keepDivs [] = []
keepDivs (div:rest)
    | isDefault div = keepDivs rest
    | otherwise = div : keepDivs rest
