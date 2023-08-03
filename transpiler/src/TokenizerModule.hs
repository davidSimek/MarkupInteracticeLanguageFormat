module TokenizerModule (keepDivs, makeDivs, Div, toTag) where

import Text.Read (readMaybe)
import Debug.Trace

-- my modules
import DivStructModule
import ColorsModule
import UtilModule

toTag :: Div -> String
toTag div = "<div style=\"background-color: rgba(" ++ show (br div) ++ ", " ++ show (bg div) ++ ", " ++ show (bb div) ++ ", " ++ show (ba div) ++ "); color: rgba(" ++ show (fr div) ++ ", " ++ show (fg div) ++ ", " ++ show (fb div) ++ ", " ++ show (fa div) ++ "); margin: " ++ outSpace div ++ " " ++ outJump div ++ "; padding: " ++ inSpace div ++ " " ++ inJump div ++ "; font: " ++ fontSize div ++ " " ++ font div ++ ";\">" ++ content div ++ "</div>\n"

makeDivs :: [String] -> [Div] -> [Div]
makeDivs [] _ = [defaultDiv { content = "end of document" }] 
makeDivs (line:rest) styles
    | getType line == "div" || getType line == "style" || getType line == "divQ" = (parse line styles: makeDivs rest (parse line styles : styles))
    | getType line == "comment" = makeDivs rest styles
    | otherwise = makeDivs rest styles


--                 defStyles
parse :: String -> [Div] ->    Div
parse [] _ = defaultDiv { content = "problem in parse function" }
parse line styles =  produceDiv (separateContent (concatMap escapeBackslash line)) styles

separateContent :: String -> [String]
separateContent [] = ["comment", "", ""]
separateContent line
    | getType line == "div"   = ["div"]   ++ splitOnN line (findSecDoub line 0 0)
    | getType line == "style" = ["style"] ++ splitOnN line (findSecHash line 0 0) 
    | getType line == "comment" = ["comment", "", ""]
    | getType line == "divQ" = ["div"] ++ splitOnNS line (findDolar line 0)
    | otherwise = ["comment", "", ""]

-- splits and removes first character
splitOnN :: String -> Int -> [String]
splitOnN (first:line) index = [take (index - 1) line, drop index line]

-- splits normally
splitOnNS :: String -> Int -> [String]
splitOnNS (line) index = [take (index - 1 ) line, drop index line]


--           line      index 
isEscapedDollar :: String -> Bool
isEscapedDollar ('\\':'$':_) = True
isEscapedDollar (_:rest) = isEscapedDollar rest
isEscapedDollar [] = False

findDolar :: String -> Int -> Int
findDolar [] index = index
findDolar ('\\':'$':rest) index = findDolar rest (index + 2) -- Skip the escaped '\$'
findDolar (char:rest) index
    | char == '$' && not (isEscapedDollar rest) = index
    | otherwise = findDolar rest (index + 1)

getType :: String -> String
getType [] = "comment"
getType ('\\':'$':rest) = getType rest
getType ('\\':'#':rest) = getType rest
getType ('\\':'"':rest) = getType rest
getType (char:rest)
    | char == '"' = "div"
    | char == '#' = "style"
    | char == '$' = "divQ"
    | char == ' ' = getType rest
    | otherwise = getType rest


findSecDoub :: String -> Int -> Int -> Int
findSecDoub [] _ currentIndex = currentIndex
findSecDoub ('\\':'"':rest) foundCount currentIndex = findSecDoub rest foundCount (currentIndex + 2)
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


--                        styles library
produceDiv :: [String] -> [Div]            -> Div
produceDiv (first:parsedContent:parsedStyle) styles
    | first == "div"   = styleDiv parsedContent parsedStyle (findStyle styles (getStyle parsedStyle)) True
    | first == "divQ"  = styleDiv parsedContent parsedStyle (findStyle styles (getStyle parsedStyle)) True
    | first == "style" = styleDiv parsedContent parsedStyle (findStyle styles (getStyle parsedStyle)) False
    | first == "comment" = defaultDiv { content = "comment" }
    | otherwise = defaultDiv { content = "comment without --" }

--          content   style       predStyle isDiv
styleDiv :: String -> [String] -> Div ->    Bool -> Div
styleDiv _ [] _ _ = defaultDiv
styleDiv parsedContent (style:_) baseStyle isDiv = baseStyle {
    isDefault = not isDiv,
    content = parsedContent,
    inSpace = if inSpace baseStyle /= inSpace defaultDiv then inSpace baseStyle else getInSpace style,
    inJump = if inJump baseStyle /= inJump defaultDiv then inJump baseStyle else getInJump style,
    outSpace  = if outSpace baseStyle /= outSpace defaultDiv  then outSpace baseStyle  else getOutSpace style,
    outJump  = if outJump baseStyle /= outJump defaultDiv  then outJump baseStyle  else getOutJump style,

    br = if br baseStyle /= br defaultDiv then br baseStyle else getColor style 'r' "bg",
    bg = if bg baseStyle /= bg defaultDiv then bg baseStyle else getColor style 'g' "bg",
    bb = if bb baseStyle /= bb defaultDiv then bb baseStyle else getColor style 'b' "bg",
    ba = if ba baseStyle /= ba defaultDiv then ba baseStyle else getBgAlpha style "bg",

    fr = if fr baseStyle /= fr defaultDiv then fr baseStyle else getColor style 'r' "color",
    fg = if fg baseStyle /= fg defaultDiv then fg baseStyle else getColor style 'g' "color",
    fb = if fb baseStyle /= fb defaultDiv then fb baseStyle else getColor style 'b' "color",
    fa = if fa baseStyle /= fa defaultDiv then fa baseStyle else getFgAlpha style "color",

    font = if font baseStyle /= font defaultDiv then font baseStyle else getFont style,                
    fontSize = if fontSize baseStyle /= fontSize defaultDiv then fontSize baseStyle else getFontSize style
}
     
findStyle :: [Div] -> String -> Div
findStyle [] styleString = defaultDiv { content = ("didn't find style" ++ styleString) }
findStyle (div:rest) nameOfStyle
    | content div == nameOfStyle = div
    | otherwise = findStyle rest nameOfStyle


keepDivs [] = []
keepDivs (div:rest)
    | isDefault div = keepDivs rest
    | otherwise = div : keepDivs rest
