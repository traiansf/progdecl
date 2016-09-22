import Data.List

sumCifre :: Int -> Int -> Int
sumCifre 0 n = 0
sumCifre m n = sumCifre m' n + c * ((c + n +1) `mod` 2)
  where
    (m',c) = m `divMod` 10

modificaElem :: [Int] -> [Int]
modificaElem l = [sumCifre n i | (n,i) <- zip l [0..]]

verificaSiruri :: [String] -> String -> Bool
verificaSiruri l s = foldr (&&) True $ map check $ filter (isPrefixOf s)  l
  where
    check s = even (length s) && (last s `elem` "aeiou")

data Expr = Const Int
          | Neg Expr
          | Expr :+: Expr
          | Expr :*: Expr
  deriving (Show)
          
data Op = NEG | PLUS | TIMES
  deriving (Show)

data Atom = AConst Int | AOp Op
  deriving (Show)

type Polish = [Atom]


fp :: Expr -> Polish
fp (Const c) = [AConst c]
fp (Neg e) = AOp NEG : fp e
fp (e1 :+: e2) = AOp PLUS : (fp e1 ++ fp e2)
fp (e1 :*: e2) = AOp TIMES : (fp e1 ++ fp e2)


extractExp :: Polish -> Maybe (Expr, Polish)
extractExp (AConst i:p) = Just (Const i, p)
extractExp (AOp NEG:p) 
  | Just (e,p') <- extractExp p = Just (Neg e, p')
extractExp (AOp o:p) 
  | Just (e,p') <- extractExp p
  , Just (e',p'') <- extractExp p' 
  = Just (app o e e', p'')
  where
    app PLUS e e' = e :+: e'
    app TIMES e e' = e :*: e'
extractExp _ = Nothing

rfp :: Polish -> Maybe Expr
rfp = fmap fst . extractExp

p1 :: Polish
p1 = [AOp TIMES, AOp PLUS, AConst 15, AOp TIMES, AConst 7, 
      AOp PLUS, AConst 2, AConst 1, AConst 3]
