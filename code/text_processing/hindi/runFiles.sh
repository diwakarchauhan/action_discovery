@echo off
set commNo=22
echo.
echo calculating the joint probability for the monograms
python conceptJointProbability.py conceptNot1conceptNot2 %commNo% _ _
python conceptJointProbability.py concept1concept2 %commNo% _ _ 
python conceptJointProbability.py conceptNot1concept2 %commNo% _ _ 
python conceptJointProbability.py concept1conceptNot2 %commNo% _ _ 

echo.
echo Calculating the Mutual Information for the monograms 
python conceptMutualinformation.py conceptNot1conceptNot2  %commNo% _ _ 
python conceptMutualinformation.py concept1concept2 %commNo% _ _ 
python conceptMutualinformation.py conceptNot1concept2 %commNo% _ _ 
python conceptMutualinformation.py concept1conceptNot2 %commNo% _ _ 

echo.
echo Calculating the Relative Frequency for the monograms 
python conceptRelativeFrequency.py conceptNot1conceptNot2 %commNo% _ _
python conceptRelativeFrequency.py concept1concept2 %commNo% _ _ 
python conceptRelativeFrequency.py conceptNot1concept2 %commNo% _ _ 
python conceptRelativeFrequency.py concept1conceptNot2 %commNo% _ _ 


echo.
echo calculating the joint probability for the bigrams
python conceptJointProbability.py conceptNot1conceptNot2 %commNo% gram2 _
python conceptJointProbability.py concept1concept2 %commNo% gram2 _ 
python conceptJointProbability.py conceptNot1concept2 %commNo% gram2 _ 
python conceptJointProbability.py concept1conceptNot2 %commNo% gram2 _ 

echo.
echo Calculating the Mutual Information for the bigram 
python conceptMutualinformation.py conceptNot1conceptNot2 %commNo% gram2 _
python conceptMutualinformation.py concept1concept2 %commNo% gram2 _ 
python conceptMutualinformation.py conceptNot1concept2 %commNo% gram2 _ 
python conceptMutualinformation.py concept1conceptNot2 %commNo% gram2 _ 

echo.
echo Calculating the Relative Frequency for the monograms 
python conceptRelativeFrequency.py conceptNot1conceptNot2 %commNo% gram2 _
python conceptRelativeFrequency.py concept1concept2 %commNo% gram2 _ 
python conceptRelativeFrequency.py conceptNot1concept2 %commNo% gram2 _ 
python conceptRelativeFrequency.py concept1conceptNot2 %commNo% gram2 _ 


echo.
echo calculating the joint probability for the trigrams 
python conceptJointProbability.py conceptNot1conceptNot2 %commNo% gram3 _
python conceptJointProbability.py concept1concept2 %commNo% gram3 _ 
python conceptJointProbability.py conceptNot1concept2 %commNo% gram3 _ 
python conceptJointProbability.py concept1conceptNot2 %commNo% gram3 _

echo.
echo Calculating the Mutual Information for the trigram 
python conceptMutualinformation.py conceptNot1conceptNot2 %commNo% gram3 _
python conceptMutualinformation.py concept1concept2 %commNo% gram3 _ 
python conceptMutualinformation.py conceptNot1concept2 %commNo% gram3 _ 
python conceptMutualinformation.py concept1conceptNot2 %commNo% gram3 _


echo.
echo Calculating the Relative Frequency for the monograms 
python conceptRelativeFrequency.py conceptNot1conceptNot2 %commNo% gram3 _
python conceptRelativeFrequency.py concept1concept2 %commNo% gram3 _ 
python conceptRelativeFrequency.py conceptNot1concept2 %commNo% gram3 _ 
python conceptRelativeFrequency.py concept1conceptNot2 %commNo% gram3 _ 

echo.
echo calculating the joint probability for the tetragram
python conceptJointProbability.py conceptNot1conceptNot2 %commNo% gram4 _
python conceptJointProbability.py concept1concept2 %commNo% gram4 _ 
python conceptJointProbability.py conceptNot1concept2 %commNo% gram4 _ 
python conceptJointProbability.py concept1conceptNot2 %commNo% gram4 _ 

echo.
echo Calculating the Mutual Information for the tetragram
python conceptMutualinformation.py conceptNot1conceptNot2 %commNo% gram4 _
python conceptMutualinformation.py concept1concept2 %commNo% gram4 _ 
python conceptMutualinformation.py conceptNot1concept2 %commNo% gram4 _ 
python conceptMutualinformation.py concept1conceptNot2 %commNo% gram4 _ 


echo.
echo Calculating the Relative Frequency for the monograms 
python conceptRelativeFrequency.py conceptNot1conceptNot2 %commNo% gram4 _
python conceptRelativeFrequency.py concept1concept2 %commNo% gram4 _ 
python conceptRelativeFrequency.py conceptNot1concept2 %commNo% gram4 _ 
python conceptRelativeFrequency.py concept1conceptNot2 %commNo% gram4 _ 
