:: collect the commentaries aand the words into a single file
@echo off
::Collect the commentaries into a single file
python collectWords.py  _ _ _
::Collect all words into a single file
python collectWords.py _ words words
::Filter all the words
python filterWords.py _ _ 
::Findl all the nGrams , check for use of filterWords in the file
python findNGrams.py _ _ _ _ 
:: collect the single concepts
python conceptCollect.py _ _ 
python conceptCollect.py concept2 _ 

:: collect the not concepts for both concepts
python notConceptCollect.py _ _
python notConceptCollect.py conceptNot2 _

:: collect the composite concepts
python multiConceptCollect.py _ _ _
python multiConceptCollect.py _ 1 1
python multiConceptCollect.py _ _ 1
python multiConceptCollect.py _ 1 _ 