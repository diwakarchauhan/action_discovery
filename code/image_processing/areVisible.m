function [visibility] = areVisible(numData, dir)
%end
if nargin < 2
    visibility = ones(numData, 1);
    return 
end

fileName = [dir '/' dir 'Data.txt'];
triangleData = load(fileName);
numData = size(triangleData, 1);
triangleOne = triangleData(:, 2:7);
triangleOneX = [triangleOne(:,1) triangleOne(:,3) triangleOne(:,5)];
triangleOneY = [triangleOne(:,2) triangleOne(:,4) triangleOne(:,6)];
triangleTwo = triangleData(:, 8:13);
triangleTwoX = [triangleTwo(:,1) triangleTwo(:,3) triangleTwo(:,5)];
triangleTwoY = [triangleTwo(:,2) triangleTwo(:,4) triangleTwo(:,6)];
centroidOne = round([mean(triangleOneX, 2), mean(triangleOneY, 2)]); 
centroidTwo = round([mean(triangleTwoX, 2), mean(triangleTwoY, 2)]);

%triangleOneX , triangleOneY,triangleTwoX, triangleTwoY;
rectangle = load([dir '/' dir 'Rectangle.txt']);
rectangleX = ones(numData, size(rectangle, 1))*rectangle(:, 1);
rectangleY = ones(numData, size(rectangle, 1))*rectangle(:, 2);
% calculate the slope of the line joining the ttwo centriods
slopeJoinLine = atan(centroidOne(:, 2) - centroidTwo(:, 2)./...
    centroidOne(:, 1) - centroidTwo(:,1));
%calculate the slpe of the line perpendicular to the mid line
projectionTriangleOneX = zeros(size(triangleOneX, 1), 3);
projectionTriangleOneY = zeros(size(triangleOneX, 1), 3);
projectionTriangleTwoX = zeros(size(triangleTwoX, 1), 3);
projectionTriangleTwoY = zeros(size(triangleTwoX, 1), 3);
slopePerpLine = -1./slopeJoinLine;
infIndices = find(slopePerpLine == -Inf | slopePerpLine == Inf);
projectionTriangleOneX(infIndices, :) = [centroidOne(infIndices, 1) ...
                centroidOne(infIndices, 1) centroidOne(infIndices, 1)];
projectionTriangleOneY(infIndices, :) = [triangleOneY(infIndices, 1)...
                triangleOneY(infIndices, 2) triangleOneY(infIndices, 3)];
projectionTriangleTwoX(infIndices, :) = [centroidTwo(infIndices, 1) ...
                centroidTwo(infIndices, 1) centroidTwo(infIndices, 1)];
projectionTriangleTwoY(infIndices, :) = [triangleTwoY(infIndices, 1)...
                triangleTwoY(infIndices, 2) triangleTwoY(infIndices, 3)];
nonInfIndices = find(slopePerpLine ~= -Inf | slopePerpLine ~= Inf);
for i = 1:3
    %x = (m^2 * xc + x1) - m*(yc - y1))/(m^ + 1)
    projectionTriangleOneX(nonInfIndices, i) = ...
        ((slopePerpLine(nonInfIndices, :).^2).*centroidOne(nonInfIndices, 1)+...
        triangleOneX(nonInfIndices, i)-...
        slopePerpLine(nonInfIndices, :).*...
        (centroidOne(nonInfIndices, 2) - triangleOneY(nonInfIndices, i)))./...
        (slopePerpLine(nonInfIndices, :).^2 + 1);
    %y = ((yc - m*xc) + m^2y1 + m*x1)/(i+m^2)
    projectionTriangleOneY(nonInfIndices, i)= ...
        ((centroidOne(nonInfIndices, 2) - ...
        slopePerpLine(nonInfIndices, :).*centroidOne(nonInfIndices, 1))...
        + (slopePerpLine(nonInfIndices).^2).* triangleOneY(nonInfIndices, i)...
        + slopePerpLine(nonInfIndices, :).* triangleOneX(nonInfIndices, i))./...
        (slopePerpLine(nonInfIndices, :).^2 + 1);
    
    projectionTriangleTwoX(nonInfIndices, i) = ...
      ((slopePerpLine(nonInfIndices).^2).*centroidTwo(nonInfIndices, 1)+...
        triangleTwoX(nonInfIndices, i)-...
        slopePerpLine(nonInfIndices, :).*...
        (centroidTwo(nonInfIndices, 2) - triangleTwoY(nonInfIndices, i)))./...
        (slopePerpLine(nonInfIndices, :).^2 + 1);
    
    projectionTriangleTwoY(nonInfIndices, i)= ...
        ((centroidTwo(nonInfIndices, 2) - ...
        slopePerpLine(nonInfIndices, :).*centroidTwo(nonInfIndices, 1))...
        + (slopePerpLine(nonInfIndices).^2).* triangleTwoY(nonInfIndices, i)...
        + slopePerpLine(nonInfIndices, :).* triangleTwoX(nonInfIndices, i))./...
        (slopePerpLine(nonInfIndices, :).^2 + 1);
end
%{
figure('visible', 'on')
imshow(zeros(240, 360));
hold on;
tmp =[centroidOne(1, 1) centroidOne(1, 2) ;centroidTwo(1,1) centroidTwo(1,2)];
plot(tmp(:,1),tmp(:,2),'x','LineWidth',1,'Color','green');
plot(triangleOneX(1, 1),triangleOneY(1, 1),'x','LineWidth',1,'Color','yellow');
plot(triangleOneX(1, 2),triangleOneY(1, 2),'x','LineWidth',1,'Color','yellow');
plot(triangleOneX(1, 3),triangleOneY(1, 3),'x','LineWidth',1,'Color','yellow');
plot(projectionTriangleOneX(1, 1),projectionTriangleOneY(1, 1),'x','LineWidth',1,'Color','red');
plot(projectionTriangleOneX(1, 2),projectionTriangleOneY(1, 2),'x','LineWidth',1,'Color','red');
plot(projectionTriangleOneX(1, 3),projectionTriangleOneY(1, 3),'x','LineWidth',1,'Color','red');
%}
maxPoints = zeros(2,2);
visibility = zeros(numData, 1);
for i = 1:numData
    d = zeros(3, 1);
    for j = 1:3
        next = (mod(j-1 , 3) + 1);
        d(j) = ((projectionTriangleOneX(i, j)-projectionTriangleOneX(i, next)).^2 ...
            + (projectionTriangleOneY(i, j) - projectionTriangleOneY(i, next)).^2); 
    end
    [m ind] = max(d);
    maxPoints(1, :) = [ind , mod(ind-1, 3) + 1];
    for j = 1:3
        next = (mod(j-1 , 3) + 1);
        d(j) = ((projectionTriangleTwoX(i, j)-projectionTriangleTwoX(i, next)).^2 ...
            + (projectionTriangleTwoY(i, j) - projectionTriangleTwoY(i, next)).^2); 
    end
    [m ind] = max(d);
    maxPoints(2, :) = [ind , mod(ind-1, 3) + 1];
    point = zeros(4,2);
    point(1, :) = [projectionTriangleOneX(i, maxPoints(1, 1)) ...
        projectionTriangleOneY(i, maxPoints(1, 1))];
    
    point(2, :) = [projectionTriangleOneX(i, maxPoints(1, 2)) ...
        projectionTriangleOneY(i, maxPoints(1, 2))];
    
    point(3, :) = [projectionTriangleTwoX(i, maxPoints(2, 1)) ...
        projectionTriangleTwoX(i, maxPoints(2, 1))];
    
    point(4, :) = [projectionTriangleTwoX(i, maxPoints(2, 2)) ...
        projectionTriangleTwoY(i, maxPoints(2, 2))];
    
    oneMid = round(mean(point(1:2, :), 1));
    twoMid = round(mean(point(3:4, :), 1));
    %to get the set of points which form supporiting lines of the triangles
    %we find the points which lie on the same side of the line joining the
    %mid point of the projection set of two triangles
    tempVal = ((point(1, 2) -oneMid(1,2))*(oneMid(1,1) - twoMid(1,1))- ...
                (oneMid(1,2) - twoMid(1,2))*(point(1,1) - oneMid(1,1)))* ...
                ((point(3, 2) -oneMid(1,2))*(oneMid(1,1) - twoMid(1,1))- ...
                (oneMid(1,2) - twoMid(1,2))*(point(3,1) - oneMid(1,1)));
    if tempVal >= 0
        %now set{point(1, :), point(3, :)} will form one supporting line
        tmp = point(2, :);
        point(2, :) = point(3, :);
        point(3, :) = tmp;
    else
        tmp = point(2, :);
        point(2, :) = point(4, :);
        point(4, :) = tmp;
        tmp = point(3, :);
        point(3, :) = point(4, :);
        point(4, :) = tmp;
    end
    % at this stage point(1, : ) and point(2, :) will form one supporting
    % line and point(3, :) and point(4, :) will form other one 
    % here we point(1, 3, :) will be of same triangle and rest from the
    % other triangle
    pt = [];
    if(abs(rectangle(1, 2) - rectangle (3,2)) > abs(rectangle(1,2) - rectangle(4,2)))
        temp = rectangle(4, :);
        rectangle(4, :) = rectangle(3, :);
        rectangle(3, :) = temp;
    %after this step 1:2 row and 3:4 row in rectangle will contain the 
    %points above each other(same x coordinate) and {1,3} and {2,4} will contain points side
    %by side to each other(same y) in the rectangular shape
    end
    
    center = round(mean(rectangle(1:4,:)));
    for j = 1:4
        t = rectangle(j, :);
        if(pointSide(point(1:2, :), t)*pointSide(point(3:4, :), t) < 0 ...
                && pointSide([point(1, :); point(3, :)], t)*...
                pointSide([point(2, :); point(4, :)], t)< 0)
            pt = [pt;t];
        end
    end
    pt2 = [];
    for j = 1:2
        t = rectangle(j+4,:);
        if(pointSide(point(1:2, :), t)*pointSide(point(3:4, :), t) < 0 ...
                && pointSide([point(1, :); point(3, :)], t)*...
                pointSide([point(2, :); point(4, :)], t)< 0)
            pt2 = [pt2;t];
        end
    end
   %we don't expect the number of points in pt  between the 
   % supporting triangles be more than 2
   %the reason might be given as the relative sizes of the triangle and
   %the rectangular box 
   if(size(pt, 1) == 0 && size(pt2, 1) == 0)
       if(pointSide(rectangle(1:2, :), point(1, :))* ...
               pointSide(rectangle(3:4, :), point(1, :)) < 0 && ...
           (pointSide(rectangle([1 3], :) , point(1, :))* ...
           pointSide(rectangle([2 4],:), point(1, :))) < 0)
       %onle point is inside the rectangle
            if(pointSide(rectangle(1:2, :), point(2, :))* ...
               pointSide(rectangle(3:4, :), point(2, :)) < 0 && ...
                (pointSide(rectangle([1 3], :) , point(2, :))* ...
                pointSide(rectangle([2 4],:), point(2, :))) < 0)
                visibility(i) = 1;
            else
                
            end
       end
       
   elseif(size(pt, 1) == 1 && size(pt2, 1) == 0)
        %measure the length of perpendiculars on the lines
        p1 = perpLength(point(1:2, :), pt);
        p2 = perpLength(point(3:4, :), pt);
        if(pointSide(point(1:2, :), pt)*pointSide(point(1:2, :), center) < 0)
            %the center of the rectangle and the point(vertex) are in
            %opposite direction of the line so the measure of hindrance
            %will be on this
            visibility(i) = p1/(p1 +p2);
        elseif(pointSide(point(3:4, :), pt)*pointSide(point(3:4, :), center) < 0)
            visibility(i) = p2/(p1+p2);
        end
    elseif(size(pt, 1) == 2 && size(pt2, 1) == 0)
        p1 = mean(perpLength(point(1:2, :), pt));
        p2 = mean(perpLength(point(3:4, :), pt));
        if(pointSide(point(1:2, :), pt(1,:))*pointSide(point(1:2, :), center) < 0)
            visibility(i) = p1/(p1+p2);
        elseif(pointSide(point(3:4, :), pt(1,:))*pointSide(point(3:4, :), center) < 0)
            visibility(i) = p2/(p1 + p2);
        end
    elseif(size(pt, 1) == 3 && size(pt2, 1) == 0)
        fprintf('This should never be the case (3, 0)\n');
    elseif(size(pt, 1) == 1 && size(pt2, 1) == 1)
        %skip
        visibility(i) = rand();
    elseif(size(pt, 1) == 2 && size(pt2, 1) == 1)
        %skip
        %visibility(i) = rand();
    elseif (size(pt, 1) == 1 && size(pt2, 1) == 2)
        %skip
        %visibility(i) = rand();
    elseif (size(pt, 1) == 2 && size(pt2, 1) == 2)
        %visibility(i) = rand();
   end
        
end

    %{
    t1 = rectangle(5, :); t2 = rectangle(6, :);
    tmpVal = zeros(4, 1);
    tmpVal(1) = pointSide(point(1:2,:), t1)*pointSide(point(3:4, :), t1);
    tmpVal(2) = pointSide([point(1, :); point(3, :)], t1)*...
        pointSide([point(2, :); point(4, :)], t1);
    tmpVal(3) = pointSide(point(1:2,:), t2)*pointSide(point(3:4, :), t2);
    tmpVal(4) = pointSide([point(1, :); point(3, :)], t2)*...
        pointSide([point(2, :); point(4, :)], t2);
    
    if(tmpVal > 0)
        if(tmpVal(3) > 0)
            if(pointSide(point(1:2, :), t1) * pointSide(point(1:2,:), t2) < 0)
                %the two points of the triangles lie on the opposite side
                %of both the supporting lines and a
                visibility(i) = 1;
            else
                visibility(i) = 0;
            end
        end
    end
    %}
end