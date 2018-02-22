function [erodeImage dilImage imageData] = eroDilate(imageData, range)
%%eroDilate: this function erodes an image and then dilates it inorder to
%remove noises in the image and create solid boundaries in the object
% imageName : Name of the image on which the process is to be applied
%%
%imageData = imread(imageName);
%imageData = rgb2gray(imageData);
if nargin < 2
    range = 1;
end

[height width] = size(imageData);
mat = -(range):range;
newImage = zeros(height, width);
newImage(1:range,:) = imageData(1:range,:);
newImage(height-range + 1,:) = imageData(height-range +1,:);
newImage(:,1:range) = imageData(:,1:range);
newImage(:,width- range + 1) = imageData(:,width-range + 1);
for i = range +1:height-range
    for j = range +1:width-range
        newImage(i,j) = max(max(imageData(i+mat, j+mat)));
    end
end
erodeImage = uint8(newImage);
for i = range+1:height-range
    for j = range+1:width-range
        newImage(i,j) = min(min(erodeImage(i+mat, j+mat)));
    end
end
dilImage = uint8(newImage);
end
