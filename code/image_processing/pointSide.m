function [tmp] = pointSide(lineSeg, point)
%this function returns a value(+ve or negative showing which side of the 
%the give point lies)

    tmp = (point(1, 2) - lineSeg(1, 2))*(lineSeg(2, 1) - lineSeg(1, 1)) - ...
        (lineSeg(2, 2) - lineSeg(1, 2))*(point(1,1) - lineSeg(1,1));
end