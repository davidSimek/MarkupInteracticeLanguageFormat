module TokenizerModule (tokenize, Div, toTag) where

data Div = Div 
    { content :: String
    , font :: String

    , br :: Int  ---------------
    , bg :: Int  -- BG colors -- 
    , bb :: Int  ---------------

    , fr :: Int  ---------------
    , fg :: Int  -- FG colors --  
    , fb :: Int  ---------------

    , margin :: Int
    , marginUnit :: String
    , padding :: Int
    , paddingUnit :: String
    }


toTag :: Div -> String
toTag div = "<div style=\"background-color:rgb(" ++ show (br div) ++ ", " ++ show (bg div) ++ ", " ++ show (bb div) ++ "), color:rgb(" ++ show (fr div) ++ ", " ++ show (fg div) ++ ", " ++ show (fb div) ++ "), margin:" ++ show (margin div) ++ marginUnit div ++ ", padding:" ++ show (padding div) ++ paddingUnit div ++ "\">" ++ content div ++ "</div>\n"

errorDiv :: Div
errorDiv = Div 
    { content = "hello"
    , font = "normal"

    , br = 255  ---------------
    , bg =   0  -- BG colors -- 
    , bb = 255  ---------------

    , fr =   0  ---------------
    , fg =   0  -- FG colors --  
    , fb =   0  ---------------

    , margin = 10
    , marginUnit = "px"
    , padding = 10
    , paddingUnit = "px"
    }


tokenize :: String -> [Div]
tokenize [] = [errorDiv] 
tokenize div = [errorDiv]
