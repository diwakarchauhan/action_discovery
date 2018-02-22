function [H] = getNeighbourhood( H, points, nhood_center)
%GETNEOGHBOURHOOD This function sets all the points in the matrix H to zero 
%   except those in the given range of points
if any(points < 0)
    disp('negative values found');
else
len = size(points, 1);
tmp = zeros(size(H));
h = H;
for i= 1:len
    p = points(i, 1); q = points(i, 2);
    p1 = p - nhood_center(1); p2 = p + nhood_center(1);
    q1 = q - nhood_center(2); q2 = q + nhood_center(2);
    % Throw away neighbor coordinates that are out of bounds in
    % the rho direction.
    [qq, pp] = meshgrid(q1:q2, max(p1,1):min(p2,size(h,1)));
    pp = pp(:); qq = qq(:);
    
    % For coordinates that are out of bounds in the theta
    % direction, we want to consider that H is antisymmetric
    % along the rho axis for theta = +/- 90 degrees.
    theta_too_low = find(qq < 1);
    qq(theta_too_low) = size(h, 2) + qq(theta_too_low);
    pp(theta_too_low) = size(h, 1) - pp(theta_too_low) + 1;
    theta_too_high = find(qq > size(h, 2));
    qq(theta_too_high) = qq(theta_too_high) - size(h, 2);
    pp(theta_too_high) = size(h, 1) - pp(theta_too_high) + 1;
    % Convert to linear indices to zero out all the values.
    tmp(sub2ind(size(tmp), pp, qq)) = 1;
end
H = H.*tmp;
end
end

