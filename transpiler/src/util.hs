module UtilModule (isNumber) where

import Text.Read (readMaybe)

isNumber :: String -> Bool
isNumber str = case readMaybe str :: Maybe Double of
  Just _ -> True
  Nothing -> False

