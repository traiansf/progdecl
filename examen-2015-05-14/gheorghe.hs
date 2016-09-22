f :: a -> [a] -> [a]
f a [] = [a]
f a (x:xs) = a : x : xs

h :: [Int] -> Bool
--h l | (filter (>= (-10)) $ filter (<= 10) l) == (filter (>= (-10)) $ filter (<= 10) $ filter (\x -> x `rem` 3 == 0) l) = True
--    | otherwise = False

--h l = filter div3 intL == intL
--  where intL = filter (>=(-10)) $ filter (<=10) l
--        div3 x = x `rem` 3 == 0

h l = foldr (&&) True $ map (== 0) $ map (`rem` 3) $ filter (<=10) $ filter (>=(-10)) l
