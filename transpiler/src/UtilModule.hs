module UtilModule (isNumber, escapeBackslash) where

import Text.Read (readMaybe)

-- checks if string represents number / is parsable
isNumber :: String -> Bool
isNumber str = case readMaybe str :: Maybe Double of
  Just _ -> True
  Nothing -> False

-- converts backslash to double backslash
escapeBackslash :: Char -> String
escapeBackslash '\\' = "\\\\"
escapeBackslash c = [c]
