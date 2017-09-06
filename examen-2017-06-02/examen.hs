-- Programare declarativă—Examen scris
-- 2 iunie 2017



-- Subiectul 1. (3,5 puncte) Elemente de bază de programare funcțională

-- Subiectul 1.1 (1 punct) Scrieți o funcție `p :: [Int] -> Int`
-- care calculează suma patratelor numerelor negative dintr-o listă dată.
-- De exemplu:

-- p [-13] == 169
-- p [] == 0
-- p [-3,3,1,-3,2,-1] == 19
-- p [2,6,-3,0,3,-7,2] == 58
-- p [4,-2,-1,-3] == 14

-- Puteți folosi *funcțiile elementare permise*, *descrieri de liste* și
-- *funcțiile din biblioteci permise*, dar nu *recursie*
-- (consultați listele de la sfârșitul documentului)

p :: [Int] -> Int
p = undefined

-- Subiectul 1.2 (1,5 puncte) Scrieți o a doua funcție `q :: [Int] -> Int`
-- care se comportă la fel ca `p`, folosind doar *funcțiile elementare permise*,
-- *recursie* și *funcțiile din biblioteci permise*, dar nu *descrieri de liste*.

q :: [Int] -> Int
q = undefined

-- Subiectul 1.3 (1 punct) Scrieți o a treia funcție `r :: [Int] -> Int`
-- care se comportă la fel ca `p`, de data aceasta folosind doar
-- *funcțiile elementare permise* și următoarele funcții
-- de ordin înalt din biblioteca standard:
-- map :: (a -> b) -> [a] -> [b]
-- filter :: (a -> Bool) -> [a] -> [a]
-- foldr :: (a -> b -> b) -> b -> [a] -> b
-- Nu puteți folosi *recursie* și *descrieri de liste*.

r :: [Int] -> Int
r = undefined

-- Subiectul 2. (3,5 puncte) Elemente avansate de programare functională.
-- Următorul tip de date reprezintă expresiile aritmetice cu o singură variabilă:

data Expresie = X -- variabila
  | Intreg Integer -- intreg
  | Expresie :+: Expresie -- adunare
  | Expresie :-: Expresie -- scadere
  | Expresie :*: Expresie -- inmultire
  | DacaMaiMic Expresie Expresie Expresie Expresie -- expresie conditionala
  deriving Show

-- `DacaMaiMic p q r s` reprezintă expresia care în Haskell ar fi scrisă ca
-- `if p < q then r else s`.

-- Subiectul 2.1 (1 punct) Scrieți o funcție `areX :: Expresie -> Bool`
-- care verifica daca intr-o expresie apare variabila `X`. De exemplu:

-- areX (Intreg 15 :+: (Intreg 7 :*: (X :-: Intreg 1))) == True
-- areX (Intreg 15 :+: (Intreg 7 :*: (Intreg 0 :-: Intreg 1))) == False

areX :: Expresie -> Bool
areX = undefined

-- Subiectul 2.2 (1 punct) Scrieți o funcție `calculeaza :: Expresie -> Integer -> Integer`
-- care, dată fiind o expresie și valoarea variabilei `X`, calculează valoarea
-- expresiei. De exemplu:

-- calculeaza (X :+: (X :*: Intreg 2)) 3 == 9
-- calculeaza (X :-: (X :*: Intreg 3)) 0 == 0
-- calculeaza (X :-: (X :*: Intreg 3)) 7 == -14
-- calculeaza (X :+: X) 2 == 4
-- calculeaza (Intreg 15 :+: (Intreg 7 :*: (X :-: Intreg 1))) 0 == 8
-- calculeaza (X :-: (X :+: X)) 4 == -4
-- calculeaza (DacaMaiMic X (Intreg 0) (Intreg 0 :-: X) X) (-7) == 7


calculeaza :: Expresie -> Integer -> Integer
calculeaza = undefined

-- Subiectul 2.3 (1,5 puncte) Scrieți o funcție `protejeaza :: Expresie -> Expresie`
-- care transformă expresia dată ca argument pentru a evita apariția
-- rezultatelor negative, in felul următor:
--
-- * Constantele negative devin 0
--
-- * La toate operațiile de scădere se adaugă o verificare că descăzutul
--   e mai mare decăt scăzătorul; în caz contrar, rezultatul scăderii va
--   deveni 0.
--
-- * Doar daca `X` apare in expresie se adaugă o verificare inițială
--   că variabila X este mai mare ca 0;
--   în caz contrar intreaga expresie va fi evaluata la 0.
--
-- Nu simplificați rezultatul prin omiterea testelor care nu par necesare.
-- De exemplu:

-- protejeaza (Intreg 5) == Intreg 5
-- protejeaza (Intreg 7 :-: Intreg 5) == DacaMaiMic (Intreg 7) (Intreg 5) (Intreg 0) (Intreg 7 :-: Intreg 5)
-- protejeaza (X :+: (X :*: Intreg 2)) == DacaMaiMic X 0 (Intreg 0) (X :+: (X :*: Intreg 2))
-- protejeaza (X :-: (X :*: Intreg 3)) == DacaMaiMic X 0 (Intreg 0) (DacaMaiMic X (X :*: Intreg 3) (Intreg 0) (X :-: (X :*: Intreg 3)))
-- protejeaza (X :+: X) == DacaMaiMic X 0 (Intreg 0) (X :+: X)
-- protejeaza (Intreg 15 :+: (Intreg 7 :*: (X :-: Intreg 1))) == DacaMaiMic X 0 (Intreg 0) (Intreg 15 :+: (Intreg 7 :*: DacaMaiMic X (Intreg 1) (Intreg 0) (X :-: Intreg 1)))
-- protejeaza (X :-: (X :+: X)) == DacaMaiMic X 0 (Intreg 0) (DacaMaiMic X (X :+: X) (Intreg 0) (X :-: (X :+: X)))

protejeaza :: Expresie -> Expresie
protejeaza = undefined

-- Subiectul 3. (2 puncte) Elemente specifice limbajului Haskell.
--Se dă următoarea secvență de declarații în Haskell:

type Id = String
data AExp = Lit Int
          | Var Id
          | Plus AExp AExp
          | Minus AExp AExp

data Stmt = Decl Id
          | If AExp Stmt Stmt
          | Id := AExp
          | Stmt :# Stmt
          | Skip
type Mem = [(Id, Int)]

-- Să se definească o funcție `run :: Stmt -> Mem` pentru a putea calcula starea
-- memoriei (Mem) în urma execuției instrucțiunii date ca argument
-- în starea inițială vidă. De exemplu:

-- run (Decl "x" :# ("x" := (Plus (Var "x") (Lit 5)))) == [("x", 5)]

-- Observatie: Puteți defini oricâte funcții ajutătoare!
-- * `Decl` adaugă o intrare nouă pentru varibila dată în memorie (dacă nu exista deja),
--   și îi dă valoarea 0 (indiferent dacă exista sau nu).
--
-- * `If` are următoarea semantică: dacă valoarea expresiei e mai mică decât 0
--   se execută prima instrucțiune, dacă nu cea de-a doua).
--
-- * Operatorul `:#` este operatorul de compunere secvențială a instrucțiunilor.
--   semantica lui este: se execută prima instrucțiune mai întâi, apoi a doua
--   instrucțiune se execută în starea de după execuția primei instrucțiuni.
--
-- * `Skip` este instrucțiunea vidă.

-- Punctaj: 2 puncte din care 1 rezolvarea, + 0,5 rezolvarea folosind monade
--          + 0,5 rezolvarea folosind monada predefinită cea mai potrivită.

run :: Stmt -> Mem
run = undefined

-- Se acordă un punct din oficiu.

{- Lista 1: Funcții elementare permise

div, mod :: Integral a => a -> a -> a
(+), (*), (-) :: Num a => a -> a -> a
(/) :: Fractional a => a -> a -> a
(^) :: (Num a, Integral b) => a -> b -> a
(<), (<=), (>), (>=) :: Ord a => a -> a -> Bool
(==), (/=) :: Eq a => a -> a -> Bool
(&&), (||) :: Bool -> Bool -> Bool
not :: Bool -> Bool
max, min :: Ord a => a -> a -> a
isAlpha, isLower, isUpper, isDigit :: Char -> Bool
toLower, toUpper :: Char -> Char
digitToInt :: Char -> Int
intToDigit :: Int -> Char
even, odd :: Integral a => a -> Bool
-}

{-Lista 2: Funcții din biblioteci permise

sum, product :: (Num a) => [a] -> a            and, or :: [Bool] -> Bool
sum [1.0,2.0,3.0] = 6.0                        and [True,False,True] = False
product [1,2,3,4] = 24                         or [True,False,True] = True

maximum, minimum :: (Ord a) => [a] -> a        reverse :: [a] -> [a]
maximum [3,1,4,2] = 4                          reverse "goodbye" = "eybdoog"
minimum [3,1,4,2] = 1

concat :: [[a]] -> [a]                         (++) :: [a] -> [a] -> [a]
concat ["go","od","bye"] = "goodbye"           "good" ++ "bye" = "goodbye"

(!!) :: [a] -> Int -> a                        length :: [a] -> Int
[9,7,5] !! 1 = 7                               length [9,7,5] = 3

head :: [a] -> a                               tail :: [a] -> [a]
head "goodbye" = ’g’                           tail "goodbye" = "oodbye"

init :: [a] -> [a]                             last :: [a] -> a
init "goodbye" = "goodby"                      last "goodbye" = ’e’

takeWhile :: (a->Bool) -> [a] -> [a]           take :: Int -> [a] -> [a]
takeWhile isLower "goodBye" = "good"           take 4 "goodbye" = "good"

dropWhile :: (a->Bool) -> [a] -> [a]           drop :: Int -> [a] -> [a]
dropWhile isLower "goodBye" = "Bye"            drop 4 "goodbye" = "bye"

elem :: (Eq a) => a -> [a] -> Bool             replicate :: Int -> a -> [a]
elem ’d’ "goodbye" = True                      replicate 5 ’*’ = "*****"

zip :: [a] -> [b] -> [(a,b)]
zip [1,2,3,4] [1,4,9] = [(1,1),(2,4),(3,9)]
-}
