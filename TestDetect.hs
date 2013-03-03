module Main where

import Control.Monad 
import qualified Data.Map as Map

import Test.HUnit 
import Detect


tPredLang :: Test
tPredLang =  TestList [(Control.Monad.liftM snd(predictLanguage "EngTest.txt")) ~?= print "ENGLISH" ]
            
  
--TestList [ (Control.Monad.liftM snd(predictLanguage "EngTest.txt")) ~?=  "ENGLISH",
    --       (Control.Monad.liftM snd(predictLanguage "ItlTest.txt")) ~?=  "ITALIAN"]

