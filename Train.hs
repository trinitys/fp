module Train where

import Control.Applicative ((<$>),(<*>))
import Data.Char (toLower, toUpper, isAlpha, isSpace)
import Data.List 
import qualified Data.Map as Map
import qualified Data.Set as S
import Directory
import System.IO
import Text.Printf
import System.Directory (getDirectoryContents)
import System.FilePath ((</>))
import Data.Binary
import Control.Monad
import Codec.Compression.GZip
    
                           
getAbsoluteDirContents :: String -> IO [FilePath]
getAbsoluteDirContents dir = do
                             contents <- filter (/= "..")<$>(filter(/= ".")<$>getDirectoryContents dir)
                             return $ map (dir </>) contents


loadNgrams :: Int -> FilePath -> IO (Map.Map [Char] Double)
loadNgrams n file =  model. nGrams n <$> readFile file


loadModels :: String -> Int -> IO [Map.Map [Char] Double]
loadModels dir n =  allFilesIn dir >>= mapM (loadNgrams n)


combine :: String -> Int -> IO (Map.Map [Char] Double)
combine dir n = Map.unionsWith (+) <$> loadModels dir n 


allFilesIn :: String -> IO [FilePath]
allFilesIn dir = getAbsoluteDirContents dir 


write :: (Show k, Show a) => Map.Map k a -> IO b
write model = do
              writeFile "Data/model_en.txt" (Map.showTree(model))
              printf "model written \n"                  


nGramsW :: Int -> String -> [[String]]
nGramsW n = takeWhile ((n ==) . length) . map (take n) .
            tails . map normalize. words 
           
nGrams :: Int -> [Char] -> [[Char]]
nGrams 0 _  = []
nGrams _ [] = []
nGrams n xs
            | length xs >= n = take n (normalize xs) : nGrams n (tail xs)
            | otherwise	     = []


normalize :: [Char] -> [Char]
normalize = map toLower . filter isAlpha

model :: [[Char]] -> Map.Map [Char] Double
--model xs = freq (Map.fromList [ (head l, length l) | l <- group (sort xs) ])
model = freq . Map.fromListWith (+) . (`zip` repeat 1)

freq :: Fractional b => Map.Map k b -> Map.Map k b
freq m = Map.map (/ total) m
         where total = foldl' (+) 0 $ Map.elems m                                                      


common :: Ord k => Map.Map k a -> Map.Map k b -> Map.Map k a                
common m1 m2 = Map.intersection m1 m2        

        

