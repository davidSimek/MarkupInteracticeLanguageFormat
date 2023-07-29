-- My Modules
import TokenizerModule

-- Standard Modules
import System.IO
import System.Environment (getArgs)
import Control.Exception (try, IOException)

main :: IO ()
main = do
    args <- getArgs
    case args of
        [filePath] -> do
            result <- try (readFile filePath) :: IO (Either IOException String)
            case result of
                Left ex -> putStrLn $ "Cannot read file: " ++ show ex
                Right contents -> putStrLn $ processFile contents
        _ -> putStrLn "You have to provide filename as an argument:\n    transpile <path>"
processFile :: String -> String
processFile [] = "<h1>It seems like your file is emp_ty</h1>"
-- processFile content = concat $ map toTag $ keepDivs $ makeDivs (lines content) []
processFile content = concat $ map toTag $ makeDivs (lines content) []



