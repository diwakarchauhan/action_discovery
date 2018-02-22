%function [] = processFrames(imageName)
image = imread(imageName);
[height width channel] = size(image);
rImage = reshape(image, height*width, channel);
rImage = double(rImage);
rImage = Km(rImage, 3);
out = zeros(height*width, channel);
for i = 1:height* width
    if rImage(i) == 1
        out(i, 1) = 255;
    elseif rImage(i) == 2
        out (i, 2) = 255;
    elseif rImage(1) == 3
        out(i, 3) = 255;
    end
end
outf = reshape(out, 240, 360, 3);
%end