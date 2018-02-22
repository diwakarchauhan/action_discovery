function [dataArray newImage, dg2] = getShapes(diffImageGray, nbrs, range, intensity)
[height width] = size(diffImageGray);
if nargin < 4
    intensity = 100;
end

if nargin < 3
    range = 4;
end

if nargin < 2
    nbrs = 10;
end    
% dancing videos nbrs = 0
% coaxing videos nbrs = 10 range = 4;
[dg1 dg2 dg3] = eroDilate(diffImageGray, 1);
%dg2 = diffImageGray;
%dg2 = dg1;
dg2(dg2< intensity) = 0;
dg2(dg2>= intensity) = 255;
imageData = dg2;
range = 4;
mat = -(range):range;
newImage = zeros(height, width);
newImage(1:range,:) = imageData(1:range,:);
newImage(height-range + 1,:) = imageData(height-range +1,:);
newImage(:,1:range) = imageData(:,1:range);
newImage(:,width- range + 1) = imageData(:,width-range + 1);
k = 0;
dataArray = zeros((height - 2*range)* (width - 2*range), 2);
count = 1;
for i = range +1:height-range
    for j = range +1:width-range
        temp = sum(sum(imageData(i+mat, j+mat)))/255;
        if (temp < nbrs)
            newImage(i,j) = 0;
        else
            newImage(i,j) = imageData(i,j);
            if(newImage(i, j) == 255)
                dataArray(count, :) = [i j];
                count = count+1;
            end
        end
    end
    k = k + 1;
end
dataArray = dataArray(1:count-1, :);
%imshow(newImage);
end