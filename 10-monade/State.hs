module State where
type Location = String
type Value = Int
type State = Location -> Maybe Value

get :: State -> Location -> Maybe Value
get s l = s l

set :: State -> Location -> Value -> State
set s l v = \ loc -> if loc == l then Just v else s loc

empty :: State
empty _ = Nothing

newtype MState a = MState (State -> (a, State))

apply :: MState a -> State -> (a,State)
apply (MState m) s = m s

instance Functor MState where
  fmap f ma = \s -> let (a,sa) = ma s in 

instance Applicative MState where
  pure = return
  (<*>) = undefined

instance Monad MState where
  return a = MState $ \s -> (a,s)
  m >>= k = MState $ \ s -> let (a,sm) = apply m s in apply (k a) sm
  