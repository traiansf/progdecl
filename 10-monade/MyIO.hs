module MyIO(MyIO, myPutChar, myGetChar, convert) where

type Input = String
type Output = String

newtype MyIO a =
  MyIO { runMyIO :: Input -> (a, Input, Output) }

myPutChar :: Char -> MyIO ()
myPutChar c = MyIO (\ input -> ((), input, [c]))

myGetChar :: MyIO Char
myGetChar = MyIO (\ (ch:input') -> (ch, input', ""))

convert :: MyIO () -> IO ()
convert m = interact (\ input ->
                let ((), _, output) = runMyIO m input
                 in output)

instance Monad MyIO where
  return x = MyIO $ \ input -> (x, input, "")
  m >>= k  = MyIO $ \ input ->
    let (x, inputx, outputx) = runMyIO m input
        (y, inputy, outputy) = runMyIO (k x) inputx
     in (y, inputy, outputx ++ outputy)

instance Applicative MyIO where
  pure      = return
  mf <*> ma = do
      f <- mf
      a <- ma
      return (f a)

instance Functor MyIO where
  fmap f ma = do  --    ma >>= return . f
      a <- ma
      return (f a)
