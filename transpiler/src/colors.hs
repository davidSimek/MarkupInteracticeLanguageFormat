module ColorsModule (colorMap, getColorRGB, getFgAlpha, getBgAlpha, getColor) where

import Text.Read (readMaybe)

import UtilModule

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
    | color == "white" = 255.0
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
