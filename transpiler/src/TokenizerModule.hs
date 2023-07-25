module TokenizerModule (tokenize) where

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
    , padding :: Int
    }


toTag :: Div -> String
toTag div = "<div style=\"background-color:rgb(" ++ show (br div) ++ show (bg div) ++ show (bb div) ++ ") \"> " ++ content div ++ "</div>\n"

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
    , padding = 10
    }


tokenize :: String -> [Div]
tokenize [] = [errorDiv] 
tokenize div = [errorDiv]
