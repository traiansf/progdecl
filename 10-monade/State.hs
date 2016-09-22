module State where
{-
type Location = String
type Value = Int
type State = Location -> Maybe Value

get :: State -> Location -> Maybe Value
get s l = s l

set :: State -> Location -> Value -> State
set s l v = \ loc -> if loc == l then Just v else s loc

empty :: State
empty _ = Nothing
-}

{-
instance Applicative MState where
  pure = return
  mf (<*>) ma = mf >>= \ f -> ma >>= \ a -> return (f a)
-}


newtype MState s a = MState (s -> (a, s))

apply :: MState s a -> s -> (a,s)
apply (MState m) s = m s

instance Functor (MState s) where
  fmap f ma = MState $ \s -> let (a,sa) = apply ma s in (f a, sa)

instance Monad (MState s) where
  return a = MState $ \s -> (a,s)
  ma >>= k = MState $ \ s -> let (a,s') = apply ma s in apply (k a) s'
  
