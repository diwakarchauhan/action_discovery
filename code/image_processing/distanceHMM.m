function distance = distanceHMM(AI, AJ)
distance = (abs(AI)*ones(size(AJ))  + AJ);
end