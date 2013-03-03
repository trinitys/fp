module Main where

 
import qualified Data.Map as Map

import Test.HUnit 
import Train

tngw :: Test
tngw = TestList [nGramsW 3 "This is a test" ~?= [["this","is","a"],["is","a","test"]],
                 nGramsW 2 "retrying to test the bi-gram in word level" ~?= [["retrying","to"],["to","test"],["test","the"],["the","bigram"],["bigram","in"],["in","word"],["word","level"]]]
       

tng :: Test
tng = TestList [nGrams 3 "This is a test" ~?= ["thi","his","isi","sis","isa","isa","sat","ate","ate","tes","tes","est"],
                 nGrams 2 "retrying to test the bi-gram in character level" ~?= ["re","et","tr","ry","yi","in","ng","gt","to","to","ot","te","te","es","st","tt","th","th","he","eb","bi","bi","ig","gr","gr","ra","am","mi","in","in","nc","ch","ch","ha","ar","ra","ac","ct","te","er","rl","le","le","ev","ve","el"]]

tnorm :: Test
tnorm = TestList [normalize " ( This is a test  !)" ~?= "thisisatest",
                  normalize " How ARE you ? -- I'm fine, Thanks!!" ~?= "howareyouimfinethanks"]


tmodel :: Test
tmodel = TestList [ model ["thi","his","isi","sis","isa","isa","sat","ate","ate","tes","tes","est"] ~?= Map.fromList [("ate",0.16666666666666666),("est",8.333333333333333e-2),("his",8.333333333333333e-2),("isa",0.16666666666666666),("isi",8.333333333333333e-2),("sat",8.333333333333333e-2),("sis",8.333333333333333e-2),("tes",0.16666666666666666),("thi",8.333333333333333e-2)]]                                                    
        

doTests :: IO ()
doTests = do 
  _ <- runTestTT $ TestList [tngw, tng, tnorm,tmodel]
  return ()