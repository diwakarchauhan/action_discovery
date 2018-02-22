currentImage = imread('0137.png');
range = 20;
pixval = 255;
[height width channel] = size(currentImage);
diffImage = currentImage;
diffImageGray = rgb2gray(diffImage);
diffImageGray(1:range,:) = pixval;
diffImageGray(height-range : height , :) = pixval;
diffImageGray(:, 1:range) = pixval; 
diffImageGray(:, width-range: width) = pixval;
imshow(diffImageGray);
diffImageGray = 255 - diffImageGray;