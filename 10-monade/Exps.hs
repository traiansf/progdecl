module Exps where

import Data.Monoid


data Token
  = Int Integer
  | Id String 

data Exp a = Token a
         | Exp a :+: Exp a
         | Exp a :*: Exp a
         | Exp a :/: Exp a
         | Exp a :%: Exp a
  deriving (Show)


newtype Adunare a = Adunare { getAdunare :: a }
  deriving (Show)

instance Num a => Monoid (Adunare a) where
    mempty = Adunare 0
    mappend (Adunare m) (Adunare n) = Adunare (m + n)


applyAll f [] = f
applyApp f (x:xs) = applyApp (f x) xs

