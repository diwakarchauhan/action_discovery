function [binIndex cArray] = Km(data, K)
%%Kmeans_impl :  This function creates k clusters of data based on the euclidian distance
%between he data points
% Data - 2D data matrix for which the clusters are to be created. Each row
% is treated as a point
% K- Number of clusters to be created
% The algorithm used here is Lloyd's iterative algorithm
%%
totalItems  = size(data, 1);
bins = cell(K,1);
fprintf('Random fill started for %d number of items', totalItems);
bins = RandomFill2(bins, data, K, totalItems);
disp('Calculating centroids after random fill..');
cArray = CalculateCentroid(bins, K);
binChange = totalItems;
val = 0;
iteration = 1;
binIndex = zeros(totalItems, 1);
disp('Clustering......');
while (binChange > val)
    for m = 1:K
        bins{m} = [];
    end
    binChange = 0;
    for dataIndex = 1:totalItems
        bIndex = 1;
        dist = sum((data(dataIndex,:) - cArray(1,:)).^2);
        minDist = dist;
        for t = 2:K
            dist = sum((data(dataIndex,:) - cArray(t,:)).^2);
            if dist < minDist
                minDist = dist;
                bIndex = t;
            end
        end
        if binIndex(dataIndex) ~= bIndex
            binChange = binChange + 1;
            binIndex(dataIndex) = bIndex;
        end
        bins{bIndex}(end + 1, :) = data(dataIndex, :);
    end
    cArray = CalculateCentroid(bins, K);
    fprintf('Number of bin changes after %dth iteration is : %d\n',...
        iteration, binChange);
    iteration = iteration + 1;
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function fills the bins randomly.
% Used at the beginning for random data distribution
function [bin] = RandomFill(bin, data, K, length)
i = 1;
index = 1;
while(i <= length)
   count = length - i + 1;
   temp = randi(count, 1);
   bin{index}(end + 1, :) = data(temp, :);
   data(temp,:) = [];
   index = mod(index , K) + 1;
   i = i + 1;
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [bin] = RandomFill2(bin, data, K, length)
index2 = 1;
for i2 = 1:K
    bin{i2}(end+1, :) = data(i2, :);
end
cArray2 = CalculateCentroid(bin, K);

for i2 = K:length
    %index2 = getNearestIndex(data(i2, :), cArray2, K);
    dist2 = sum((data(i2,:) - cArray2(1,:)).^2);
    minDist2 = dist2;
    for t2 = 2:K
        dist2 = sum((data(t2,:) - cArray2(t2,:)).^2);
        if dist2 < minDist2
            minDist2 = dist2;
            index2 = t2;
        end
    end
    bin{index2}(end+1, :) = data(i2, :);
    cArray2(index2, :) = (cArray2(index2, :) * (size(bin{index2}, 1)-1) ...
        + data(i2, :))/ size(bin{index2}, 1);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the centroids of given set of bins
function [cArray] = CalculateCentroid(bins, K)
temp = size(bins{1}, 2);
cArray = zeros(K, temp);
for i = 1:K
    num = size(bins{i}, 1); % number of elements in current bean
    if num ~= 0
        cArray(i, :) = sum(bins{i}, 1) ./ num;
    else
        cArray(i,:) = 0;
    end
    
end

end
