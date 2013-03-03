Language Detection

This project is a language detection module which trains itself on existing 
files in target languages and aims at being able to correctly predict the 
language of a new unseen test file. 
The targeted languages right now are English, German, French,Portuguese,
Spanish,Chinese and Italian which may be extended to other languages for which 
sufficient and diverse training data is available. 


Main
----
This primarily is a driver module. It asks user for an input file , the language
of which is to be detected. Then, it calls the Detect module to carry out the 
actual detection algorithm.


Model
------
This is sort of a parameter listing which identifies language models for each 
target language, the value of N in the N-gram model (it is critical for this 
value to be consistent across training and testing)and the path to the training 
data.


Train
-----
This module actually creates the N-gram language models by training over all 
text files at a given location. It creates N-grams in each training document, 
calculates its normalized frequency and stores that as an N-gram to frequency
map. This essentially defines the model for a language.


Detect
------
This module gets the test file, creates an identical model (same N) as training 
data and measures how similar the test model is to each of the existing language
models obtained during training. The highest similarity corresponds to the 
output as the predicted language. The similarity measure here could be any of 
the similarity metrics defined in Similarity module.


Similarity
----------
This is a standalone module that defines similarity metrics to be used with 
text. This is extensible but right now defines two metrics , one of which , the 
cosine similarity metric is used by the Detect module.

Serialization
-------------
This module has functions to store the model in a compressed binary format using
the efficient Data.Binary module. It also has a reverse function to retrive the 
model from the binary.This module is not currently being used. However, as 
training data increases in the interest of better accuracy, the model should be
generated and stored. This can be reloaded to be compared against test documents.
The training data should be regenerated only when there is new training data 
added to the set. 

Test Modules
---------
These are test modules containing HUnit tests corresponding to each module
(except Model).


























