%function [] = getRectangle()
%end
directory = '../database/ImageChase';
currentImage = imread([directory '/' '0051.png']);
standardImage = imread([directory '/' '0004.png']);
diffImage = standardImage - currentImage;
diffImage = rgb2gray(diffImage);
diffImage = imresize(diffImage, [240 360]);
[r h] = size(diffImage);
[data image dg] = getShapes(diffImage, 0, 0, 60);
[dataOrigin imageOrigin gdOrigin] = getShapes(255 ...
            -rgb2gray(imresize(currentImage, [240 360])), 0, 0, 60);
tempImage = zeros(size(diffImage));
tempImage(20:220, 25:335) = imageOrigin(20:220,25:335);

squareImage = tempImage - image; %imageOrigin(3:237, 4:356);
%imshow(image)
pth = ['test1' '/' 'check' '.lim.png'];
%image = edge(image,'canny');
[bw, vertices reducedImage1 P] = houghTest(squareImage, 0.3,...
    3,pth, 0);
pth = ['test1' '/' 'check' '.sim.png'];
%[data reducedImage dg]= getShapes(reducedImage, 5,2, 100); 
%[bw vertices reducedImage P] = houghTest(reducedImage, 0.2, ...
%    2, pth, 0);
%close;