module Lib where

import           Data.Function (on)
import           Data.List     (group, groupBy, sort, sortOn)


type Linie = Integer
type Coloana = Integer


type Partida = [(Linie, Coloana)]

uninterleave :: [a] -> ([a], [a])
uninterleave [] = ([], [])
uninterleave (a:as) = (a:as2, as1)
  where (as1, as2) = uninterleave as

sorteazaPeLinii :: Partida -> Partida
sorteazaPeLinii = sort

{-
sorteazaPeColoane :: Partida -> Partida
sorteazaPeColoane = sortOn (\(a,b) -> (b,a))

sorteazaPeDiag1 :: Partida -> Partida
sorteazaPeDiag1 = sortOn (\(a,b) -> (a - b,a))

sorteazaPeDiag2 :: Partida -> Partida
sorteazaPeDiag2 = sortOn (\(a,b) -> (a + b, a))
-}

grupeazaDupaPrimul :: Partida -> [Partida]
grupeazaDupaPrimul = groupBy ((==) `on` fst)

grupeazaDupa :: (a -> a -> Bool) -> [a] -> [[a]]
grupeazaDupa test [] = []
grupeazaDupa test (a:as) =
    case ass of
        [] -> [[a]]
        (as'@(a':_):ass')
            | test a a' -> (a:as'):ass'
            | otherwise -> [a]:as':ass'
  where
    ass = grupeazaDupa test as


consecutiv :: Integer -> Integer -> Bool
consecutiv a b = a + 1 == b

grupeazaConsecutive :: Partida -> [Partida]
grupeazaConsecutive = grupeazaDupa (consecutiv `on` snd)

secventeInLinie :: Partida -> [Partida]
secventeInLinie =
    concatMap grupeazaConsecutive
    . grupeazaDupaPrimul

maxInLinie :: Partida -> Partida
maxInLinie = head . sortOn (negate.length) . secventeInLinie

areDuplicate :: Partida -> Bool
areDuplicate = any ((>1).length) . group . sort

someFunc :: IO ()
someFunc = undefined
