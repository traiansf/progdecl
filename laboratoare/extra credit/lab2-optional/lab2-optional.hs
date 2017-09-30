-- Declarative Programming
-- Lab 2
--

import Data.Char
import Data.List
import Test.QuickCheck


-- Optional Material

-- 8. crosswordFind

-- List-comprehension version
crosswordFind :: Char -> Int -> Int -> [String] -> [String]
crosswordFind = undefined

-- Recursive version
crosswordFindRec :: Char -> Int -> Int -> [String] -> [String]
crosswordFindRec = undefined

-- Mutual test
prop_crosswordFind :: Char -> Int -> Int -> [String] -> Bool
prop_crosswordFind = undefined 



-- 9. search

-- List-comprehension version

search :: String -> Char -> [Int]
search = undefined

-- Recursive version
searchRec :: String -> Char -> [Int]
searchRec = undefined

-- Mutual test
prop_search :: String -> Char -> Bool
prop_search = undefined


-- 10. contains

-- List-comprehension version
contains :: String -> String -> Bool
contains = undefined

-- Recursive version
containsRec :: String -> String -> Bool
containsRec = undefined

-- Mutual test
prop_contains :: String -> String -> Bool
prop_contains = undefined

