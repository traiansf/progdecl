import           Data.Char
import           MyIO

myPutStr :: String -> MyIO ()
myPutStr = foldr (>>) (return ()) . map myPutChar

myPutStrLn :: String -> MyIO ()
myPutStrLn s = myPutStr s >> myPutChar '\n'

myGetLine :: MyIO String
myGetLine = do
  x <- myGetChar
  if x == '\n'
    then return []
    else do
      xs <- myGetLine
      return (x:xs)

myEcho :: MyIO ()
myEcho = do
  line <- myGetLine
  if line == ""
    then return ()
    else do
      myPutStrLn (map toUpper line)
      myEcho

main :: IO ()
main = convert myEcho
