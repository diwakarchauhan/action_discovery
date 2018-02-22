function [perp] = perpLength(line, point)
slope = (line(2, 2) -line(1, 2))/(line(2, 1) - line(1,1));
if( abs(slope) == Inf)
    perp = point(:,1) - line(1, 1);
else
    perp = (slope*(point(:,1) - line(1,1)) + line(1,2) - point(:,2))/...
        ((slope^2 + 1)^(0.5));
end