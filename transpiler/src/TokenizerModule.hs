module TokenizerModule (tokenize, Div, toTag) where

data Div = Div 
    { content :: String
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
    { content = "hello"
    , font = "normal"

    , br = 255  ---------------
    , bg =   0  -- BG colors -- 
    , bb = 255  ---------------
    , ba = 1.0

    , fr =   0  ---------------
    , fg =   0  -- FG colors --  
    , fb =   0  ---------------
    , fa =   1.0

    , margin = 10
    , marginUnit = "px"
    , padding = 10
    , paddingUnit = "px"
    }


defaultDiv :: Div
defaultDiv = Div 
    { content = ""
    , font = "13px Arial, sans-serif"

    , br = 255  ---------------
    , bg =   0  -- BG colors -- 
    , bb = 255  ---------------
    , ba =   0

    , fr =   0  ---------------
    , fg =   0  -- FG colors --  
    , fb =   0  ---------------
    , fa =   1.0

    , margin = 10
    , marginUnit = "px"
    , padding = 10
    , paddingUnit = "px"
    }



tokenize :: String -> [Div]
tokenize [] = [errorDiv] 
tokenize div = [errorDiv]
