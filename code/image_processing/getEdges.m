function [eg v1 v2 v3 image1] = getEdges(Triangle,dim,range)
if nargin < 3
    range = 3;
end

length = size(Triangle, 1);
[indx C] = kmeans(Triangle, 3);
%the three centers returned by k-means will be approximated as the vertices
image = zeros(240, 360, 3);
image1 = seperateparts(image, Triangle, 1);
image1 = seperateparts(image1, round(C), 2);
imshow(image1);
m = zeros(3,1);
m(1) = (C(1,2) - C(2,2))/(C(1,1) - C(2,1));
m(2) = (C(2,2) - C(3,2))/(C(2,1) - C(3,1));
m(3) = (C(3,2) - C(1,2))/(C(3,1) - C(1,1));
cEdge = zeros(length, 5);
cEdge(:,4:5) = Triangle(:,1:2);
eg = cell(3,1);
for j = 1:3
    cEdge(:,j) = round(Triangle(:,2) - m(j)*Triangle(:,1));
    temp = cEdge(:,j)';
    [p q] = hist(temp, unique(temp));
    len = size(p);
    histData = zeros(2, len(2));
    histData(1,:) = p;
    histData(2,:) = q;
    histData = histData';
    histData = sortrows(histData, 1);
    c = histData(len(2),2);
    edge = zeros(length, 2);
    count = 1;
    for i = 1:length
        if abs(cEdge(i,j) - c) < range
            edge(count, :) = cEdge(i, 4:5);
            count = count +1;
        end
    end
    count
    edge = edge(1:count-1,:);
    eg{j} = edge;
end
count = 1;
for i = 1:3
    if size(eg{i}, 1) >= length/5
        eg{count} = eg{i};
        count = count + 1;
    end
end
if count == 3 % only two edges are obtained clearly
    disp('only two edges were found');
    v1 = intersect(eg{1}, eg{2}, 'rows');
    minTemp = round(min(eg{1}));
    maxTemp = round(max(eg{2}));
    if sum((v1 - minTemp).^2) < sum((v1 - maxtemp).^2)
        v2 = maxTemp;
    else
        v2 = minTemp;
    end
    minTemp = round(min(eg{2}));
    maxTemp = round(max(eg{2}));
    if sum((v1 - minTemp).^2) < sum((v1 - maxtemp).^2)
        v3 = maxTemp;
    else
        v3 = minTemp;
    end
    image = zeros(dim(1), dim(2), 3);
    image1 = seperateparts(image, v1, 1);
    image1 = seperateparts(image1, v2, 2);
    image1 = seperateparts(image1, v3, 3);
elseif count == 4 % all the 3 edges are found
    disp('all the edges found');
    image = zeros(dim(1), dim(2), 3);
    image1 = seperateparts(image, eg{1}, 1);
    image1 = seperateparts(image1, eg{2}, 2);
    image1 = seperateparts(image1, eg{3}, 3);
    imshow(image1);
    v1 = intersect(eg{1}, eg{2}, 'rows');
    v2 = intersect(eg{2}, eg{3}, 'rows');
    v3 = intersect(eg{3}, eg{1}, 'rows');
    eg
    if (isempty(v1)||isempty(v2)|| isempty(v3))
        fprintf(['One or more vertices not found' ...
        'Try to increase the value of range']);
    if isempty(v1)
        disp('v1');
    end
    if isempty(v2)
        disp('v2');
    end
    if isempty(v3)
        disp('v3');
    end
    end
    v1 = round(mean(v1, 1))
    v2 = round(mean(v2, 1))
    v3 = round(mean(v3, 1))
end
