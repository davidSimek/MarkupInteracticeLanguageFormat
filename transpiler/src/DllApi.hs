module DllApi where

-- My Modules
import TokenizerModule

-- Standard Modules
import System.IO
import System.Environment (getArgs)
import Control.Exception (try, IOException)
import Foreign.C.String
import Foreign.C.Types

foreign export ccall hTranspile :: CString -> IO CString

hTranspile :: CString -> IO CString
hTranspile content = do
    input <- peekCString content
    let output = processContent input 
    newCString output

processContent :: String -> String
processContent [] = "<h1>It seems like your file is emp_ty</h1>"
processContent content = concat $ map toTag $ keepDivs $ makeDivs (lines content) []
-- concat $ map toTag $ keepDivs $ makeDivs (lines content) []



