function optimalClass = determineClass(Data, M , f, Kmin, Kmax)
    kPlus = Kmax + 1;
    highCluster = linkage(Data, 'centroid', '@distanceHMM');
    for i = 1:M
        index = randperm(length(Data));
        index = index(1:round(f*length(Data)));
        newData = data(index);
    end
end