function [ side] = getTriangle( vertex, width)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    width = 2;
end
vrt = vertex;
numVertex = size(vertex, 1);
side = cell(numVertex, 1);
for i = 1:numVertex
    vrt1 = vrt(i, :);
    vrt2 = vrt(mod(i, numVertex) + 1, :);
    m = (vrt1(2) - vrt2(2))/(vrt1(1)-vrt2(1));
    
    if abs(m) < 1
        len = abs(vrt1(1) - vrt2(1))+1;
        y = zeros((2*width+1)*len, 1);
        X = zeros((2*width+1)*len, 1);
        x = min(vrt1(1),vrt2(1)):max(vrt1(1),vrt2(1));
        x = x';
        for j = 1:(2*width+1)
            y((j-1)*len + 1:j*len,1) = m*(x - vrt1(1)) + vrt1(2) + j - width - 1;
            X((j-1)*len + 1:j*len,1) = x;
        end
        X = round(X);
        y = round(y);
        side{i} = [y X];
    else
        len = abs(vrt1(2) - vrt2(2)) + 1;
        Y = zeros((2*width+1)*len, 1);
        x = zeros((2*width+1)*len, 1);
        y = min(vrt1(2),vrt2(2)):max(vrt1(2),vrt2(2));
        y = y';
        m = 1/m;
        for j = 1:(2*width+1)
            x((j-1)*len + 1:j*len,1) = m*(y - vrt1(2)) + vrt1(1) + j - width - 1;
            Y((j-1)*len + 1:j*len,1) = y;
        end
        x = round(x);
        Y = round(Y);
        side{i} = [Y x];
    end
end
end
