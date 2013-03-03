module Model where

import Train
import Directory

dataFolder = "Data/Training_small/"
nValue = 3

enModel = Train.combine (dataFolder ++ "en") nValue  
esModel = Train.combine (dataFolder ++ "es") nValue
ptModel = Train.combine (dataFolder ++ "pt") nValue
itModel = Train.combine (dataFolder ++ "it") nValue
frModel = Train.combine (dataFolder ++ "fr") nValue
zhModel = Train.combine (dataFolder ++ "zh") nValue
deModel = Train.combine (dataFolder ++ "de") nValue

          