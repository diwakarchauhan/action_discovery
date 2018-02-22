function [cc, image1] = test1(image)
[height width ] = size(image);
rMin = 1;
rMax = 1;
wMin = 1;
wMax = 1;
temp = 255;
temp1 = 0;
for i = 1:height
    if max(image(i,:)) == temp && temp1 ==  0
        rMin = i;
        temp1 = 1;
    end
    if max(image(i,:)) == temp && temp1 == 1  
        rMax = i;
    end
end
temp = 255;
temp1 = 0;
for i = 1:width
    if (max(image(:,i) == temp) && temp1 == 0)
        wMin = i;
        temp1 = 1;
    end
    if (max(image(:,i) == temp) && temp1 == 1)
        wMax = i;
    end
end
image1 = image(rMin:rMax, wMin:wMax);
%{
imshow(image1);
cc = bwconncomp(image1);
numObj = cc.NumObjects ;
if (numObj~= 2)
    disp('more than two components found')
end
%}
end


function [] = test()
im1 = imread('0036.png');
im2 = imread('0002.png');
diffImage = im2-im1;
diffImageGray = rgb2gray(diffImage);

kernel = -ones(3)/8;
kernel(2,2) = 1;
[data image] = getShapes(diffImageGray, 0, 0, 60);
[height width ] = size(image);
cv = conv2(image, kernel);
t = atan(cv);
for i = 1:height
cv(i, :) = cv(i, :) - mean(cv);
end
for i = 1:height
    cv(i,:) = cv(i,:) ./ var(cv);
end

[h w] = size(data);
rho = zeros(h, 1);
c = zeros(h , 1);
for i = 1:h
cs = cos(t(data(i,1), data(i,2)));
sn = sin(t(data(i,1), data(i,2)));
rho(i,1) = cs.*data(i,1) + sn.* data(i,2);
c(i, 1) = data(i, 2) - data(i,1)*cv(data(i,1) , data(i,2));
end
rho = round(rho);
sortrows(rho)
size(rho)
c = round(c);
c = sortrows(c);
%[a b] = kmeans(rho, 6);
%[p q]  = kmeans(c, 6);
end