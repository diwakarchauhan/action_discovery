function [intersection] = intersectionPoint(lineOne, lineTwo)

%lineOne is the two points forming the first line
%lineTwo is the two points forming the second line
m = zeros(2, 1);
m(1) = (lineOne(2, 2) - lineOne(1, 2))/(lineOne(2,1) - lineOne(1,1));
m(2) = (lineTwo(2, 2) - lineTwo(1, 2))/(lineTwo(2,1) - lineTwo(1,1));
if(abs(m(1) - m(2)) == 0 | (abs(m) == [Inf ;Inf]))
    intersection = [Inf Inf];
elseif  (abs(m(1)) == Inf)
    intersection = [lineOne(1,1) m(2)*(lineOne(1,1) - lineTwo(1,1))...
        - lineTwo(1,2)];
elseif (abs(m(2)) == Inf)
    intersection = [lineTwo(1,1) lineOne(1,2) - m(2)*(lineOne(1,1) - ...
        lineTwo(1,1))];
else
    intersection = round([(m(2)*lineTwo(1,1) + lineOne(1,2) - lineTwo(1, 2) - ...
        lineOne(1,1)*m(1))/(m(2) - m(1)) ...
        (m(2)*lineOne(1,2) - m(1)*lineTwo(1,2) - m(1)*m(2)*(lineOne(1,1) ...
        - lineTwo(1,1)))/(m(2) - m(1))]);
end

end