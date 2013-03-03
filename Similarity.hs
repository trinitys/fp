module Similarity
where

import qualified Data.Map as Map


cosine :: (Ord k, Floating a) => Map.Map k a -> Map.Map k a -> a
cosine a b  = (dot a b) / ((norm a) * (norm b)) where
                 dot x y = sum (Map.elems ( Map.intersectionWith (*) x y ))
                 norm = sqrt . sum . fmap (^2) . Map.elems

levenshtein::String->String->Int
levenshtein s t =  d!!(length s)!!(length t) where
                   d = [[distance m n|n<-[0..length t]]|m<-[0..length s]]
                   distance i 0 = i
                   distance 0 j = j
                   distance i j = minimum [d!!(i-1)!!j+1, d!!i!!(j-1)+1, d!!(i-1)!!(j-1) + (if s!!(i-1)==t!!(j-1) then 0 else 1)]
