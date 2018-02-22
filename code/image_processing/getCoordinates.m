function [ dg diffImage] = getCoordinates(directory, in1, in2)
imageData = dir(directory);
if nargin < 3
    if nargin < 2
        in1 = 1;
    end
    in2 = size(imageData,1);
end
fp = fopen(['test.txt'], 'w');
count = 1;
previousLarge = -100*ones(3, 2);
previousSmall = -100*ones(3, 2);
for i = in1:in2 %size(imageData, 1)
    close all;
    if (imageData(i).isdir == 0)
        imageName = [directory '/' imageData(i).name];
        fprintf('%s\n', imageData(i).name);
        currentImage = imread(imageName);
        standardImage = imread([directory '/' imageData(4).name]);
        diffImage = standardImage - currentImage;
        diffImage = rgb2gray(diffImage);
        diffImage = imresize(diffImage, [240 360]);
		%tmpImage = zeros(size(diffImage));
        %tmpImage(20:220, 20:335) = diffImage(20:220, 20:335);
        %diffImage = tmpImage;
        %imshow(diffImage)
        [r h] = size(diffImage);
        [data image dg] = getShapes(diffImage, 0, 0, 60);
        %imshow(image)
        disp('fist pass');
        pth = ['test1' '/' imageData(i).name '.lim.png'];
        %image = edge(image,'canny');
        [bw, vertices reducedImage P] = houghTest(image, 0.3,...
            6,pth, previousLarge);
        previousLarge = P;
        fprintf(fp, '%s ', imageData(i).name);
        for j = 1:3
            fprintf(fp, '%d %d ',vertices(j,1), vertices(j, 2));
        end
        disp('second pass');
        pth = ['test1' '/' imageData(i).name '.sim.png'];
        %[data reducedImage dg]= getShapes(reducedImage, 5,2, 100); 
        [bw vertices reducedImage P] = houghTest(reducedImage, 0.2, ...
             6, pth, previousSmall);
         previousSmall = P;
        for j = 1:3
            fprintf(fp, '%d %d ',vertices(j,1), vertices(j, 2));
        end
        %for j = 1:3
        %    fprintf(fp, '%d %d ', NaN, NaN);
        %end
        
        fprintf(fp, '\n');
        %[data image dg] = getShapes(reducedImage,4, 20, 100);
        %imshow(image)
        %{
        im = zeros(r, h, 3);
        im(:,:, 1) = image;
        im = seperateparts(im, cl{1}, 1);
        im = seperateparts(im, cl{2}, 2);
        im = seperateparts(im, cl{3}, 3);
        imwrite(im, ['tests' '/' imageData(i).name 'smt.jpg'], 'jpg');
        %[rImage vertexSmall] = houghTest(image, 6, 2);
        im = zeros(r, h, 3);
        temp = zeros(size(vertexLarge));
        temp(:,1) = vertexLarge(:,2);
        temp(:,2) = vertexLarge(:,1);
        im = seperateparts(im,temp,1);
        %im = seperateparts(im,vertexSmall,2);
        imwrite(im, ['test' '/' imageData(i).name '.jpg'], 'jpg');
        %}
    end
end
fclose(fp);
end