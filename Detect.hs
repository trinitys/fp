module Detect where

import Control.Applicative ((<$>),(<*>))
import Data.List 
import Control.Monad 
import qualified Data.Map as Map
import qualified Data.Set as S
import Train
import Similarity (cosine)
import qualified Model as M




--predictLanguage file = simMap file >>= Map.findMax
  
predictLanguage :: FilePath -> IO (Double, [Char])
predictLanguage file  = do
                         keys <- mapM (cosine <$>inputModel<*>)[M.deModel,M.enModel,M.esModel,M.frModel,M.ptModel,M.itModel]
                         let langs = zip keys ["GERMAN","ENGLISH","SPANISH","FRENCH","PORTUGUESE","ITALIAN"]
                         return (Map.findMax (Map.fromList langs))
                         where inputModel = Train.loadNgrams M.nValue file

--insertValue :: [Char] -> Map Double [Char] -> -> IO (Map Double [Char])
insertValue value m inputModel langModel = do
                                           key <- cosine <$>inputModel <*>langModel
                                           return $ Map.insert key value   
                                       








        

        

