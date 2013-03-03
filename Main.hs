module Main
where

import List
import Directory
import Text.Printf
import Detect
import Control.Applicative ((<$>))
import Control.Monad
import qualified Data.Map as Map
import System.IO

main :: IO ()
main = do
        d <- getCurrentDirectory
	printf "You are currently at  %s\n" d 
        putStr "Please enter the relative path to your input file: "
        ifile <- getLine
        fileExists <- doesFileExist ifile  
        if fileExists  then do putStr "Comparing with existing language models...\n"
                               ans <- (Control.Monad.liftM snd (Detect.predictLanguage ifile))
                               sim <- (Control.Monad.liftM fst (Detect.predictLanguage ifile))
                               if sim == 0.0 
                                 then printf "Sorry! Doesn't look like a language I know.\n"
                                 else if sim > 0.1
                                      then printf "My best guess is :%s\nThey look about %f percent similar\n" ans (sim * 100)   
                                      else printf "This looks about %f percent similar to %s but I don't have enough data to predict.Sorry!\n" (sim * 100) ans 
        else do putStrLn "Cannot find file."
      
        