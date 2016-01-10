module Interpret where

import Control.Monad

type Name = String

type Location = Int

data Term
  = Var Name
  | Loc Location
  | Ref Term
  | Get Term
  | Set Term Term
  | Con Int
  | Add Term Term
  | Lam Name Term
  | App Term Term


data Value m
  = Wrong
  | Num Int
  | Loca Location
  | Fun (Value m -> m (Value m))
  
instance Show (Value m) where
  show Wrong = "<wrong>"
  show (Num i) = show i
  show (Loca l) = "<" ++ show l ++ ">"
  show (Fun f) = "<function>"

type Environment m = [(Name,Value m)]

lookUp :: Monad m => Name -> Environment m -> m (Value m)
lookUp _ [] 
  = return Wrong
lookUp x ((y,b):e)
  = if x == y then return b else lookUp x e


interp :: Monad m => Term -> Environment m -> m (Value m)
interp (Var x) e   = lookUp x e
interp (Con i) e   = return (Num i)
interp (Lam x v) e = return (Fun (\a -> interp v ((x,a):e)))
interp (Add u v) e = 
  do {
    a <- interp u e;
    b <- interp v e;
    add a b
  }
interp (App t u) e = 
  do {
    f <- interp t e;
    a <- interp u e;
    apply f a
  }
interp (Ref )

add :: (Monad m) => Value m -> Value m -> m (Value m)
add (Num i) (Num j) = return (Num (i+j))
add _ _ = return Wrong

apply :: (Monad m) => Value m -> Value m -> m (Value m)
apply (Fun k) a = k a
apply _ _ = return Wrong

newtype Identity a = Id a
instance Monad Identity where
  return a   = Id a
  Id a >>= k = k a

instance (Show a) => Show (Identity a) where
  show (Id a) = show a

evalId :: Term -> String
evalId t = show $ interp t ([]::Environment Identity)

-- (λx. λy. (y (λz. x x y z))) (λx. λy. (y (λz. x x y z)))
y :: Term 
y = App f f 
  where
    f = (Lam "x" (Lam "y" (App (Var "y" (Lam "z" (App (App (App (Var "x") (Var "x")) (Var "y")) (Var "z")))))))

-- factorial functor
factF :: Term
fatcF = (Lam "f" (Lam "x" (


data Error a = Success a | Error String
  (deriving Show)

instance Monad Error where
  return a = Success a
  fail   s = Error s
  (Success a) >>= k = k a
  (Error s)   >>= k = Error s

type Store = Location -> Value

newtype State a = State (Store -> (a,Store))  
  
instance Monad   