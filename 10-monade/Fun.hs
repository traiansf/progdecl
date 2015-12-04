import Data.Functor
data Tree a = Node a (Tree a) (Tree a)
            | Leaf a
  deriving (Show)

instance Functor Tree where
  fmap f (Leaf x) = Leaf $ f x
  fmap f (Node x left right) = Node (f x) (fmap f left) (fmap f right)

tree :: Tree Int
tree = Node 5 (Node 3 (Leaf 1) (Leaf 4)) (Leaf 7)
