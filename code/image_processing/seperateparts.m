function [cImage] = seperateparts(image, data, channel)
[height width ch]= size(image);
[len dim] = size(data);
%cel = cell(number,1);
%for i = 1:number
%    cel{i} = zeros(height, width);
%end
%for i = 1:number
%    cel{i}((image - (i-1)*ones(height, width)) == 0) = 1;
%end
cImage = zeros(height, width, 3);
cImage = image;
for i = 1:len
    x = data(i,1);
    y = data(i,2);
    cImage(x,y, channel) = 255;
end
cImage = uint8(cImage);
end
