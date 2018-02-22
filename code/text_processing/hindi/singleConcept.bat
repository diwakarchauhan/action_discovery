@echo off

echo.
echo Calculating the Relative frequency measure for Concept 1
python conceptRelativeFrequency.py _ _ _ _ 
python conceptRelativeFrequency.py _ _ gram2 _ 
python conceptRelativeFrequency.py _ _ gram3 _ 
python conceptRelativeFrequency.py _ _ gram4 _

echo.
echo Calculating the Joint Probability for Concept 1
python conceptJointProbability.py concept1 22 _ _ 
python conceptJointProbability.py concept1 22 gram2 _
python conceptJointProbability.py concept1 22 gram3 _
python conceptJointProbability.py concept1 22 gram4 _
 
echo.
echo Calculating the mutual information for concept 1
python conceptMutualinformation.py concept1 22 _ _ 
python conceptMutualinformation.py concept1 22 gram2 _ 
python conceptMutualinformation.py concept1 22 gram3 _ 
python conceptMutualinformation.py concept1 22 gram4 _ 

echo.
echo Calculating the Relative frequency measure for Concept 2
python conceptRelativeFrequency.py concept2 _ _ _ 
python conceptRelativeFrequency.py concept2 _ gram2 _ 
python conceptRelativeFrequency.py concept2 _ gram3 _ 
python conceptRelativeFrequency.py concept2 _ gram4 _

echo.
echo Calculating the Joint Probability for Concept 2
python conceptJointProbability.py concept2 22 _ _ 
python conceptJointProbability.py concept2 22 gram2 _
python conceptJointProbability.py concept2 22 gram3 _
python conceptJointProbability.py concept2 22 gram4 _


echo.
echo Calculating the mutual information for concept 2
python conceptMutualinformation.py concept2 22 _ _ 
python conceptMutualinformation.py concept2 22 gram2 _ 
python conceptMutualinformation.py concept2 22 gram3 _ 
python conceptMutualinformation.py concept2 22 gram4 _ 
