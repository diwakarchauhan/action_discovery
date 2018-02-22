function [triangle1 triangle2] = seperate(triangleData, thres)
numData = size(triangleData, 1);
xData = sortrows(triangleData, 1);
yData = sortrows(triangleData,2);
xTemp = zeros(numData, 1);
yTemp = zeros(numData, 1);
xCount = 0;
yCount = 0;
for i = 2:numData
    if(abs(xData(i,1) - xData(i-1, 1)) > thres)
        xCount = xCount + 1;
        xTemp(xCount) = i;
    end
    
    if(abs(yData(i,2) - yData(i-1,2)) > thres)
        yCount = yCount + 1;
        yTemp(yCount) = i;
        %abs(yData(i,2) - yData(i-1, 2))
    end
end
xCount
yCount
triangle1 = [];
triangle2 = [];
if xCount ~= 0
    if xCount == 1
        triangle1 = xData(1:(xTemp(xCount)-1),:);
        triangle2 = xData(xTemp(xCount):numData, :);
    %xTemp = xTemp(1:xCount, :);
    end
end
if yCount ~= 0
    %yTemp = yTemp(1:yCount, :);
    if yCount == 1
        triangle1 = yData(1:yTemp(yCount)-1, :);
        triangle2 = yData(yTemp(yCount):numData, :);
    end
end
end
