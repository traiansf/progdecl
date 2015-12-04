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


class Mono a where
    unit :: a
    aop :: a -> a -> a

instance Mono [a] where
    unit = []
    aop = (++)
