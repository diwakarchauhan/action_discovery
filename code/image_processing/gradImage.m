kernel = [-1 0 1];
range = 2;
[height, width, channel] = size(image);
image = double(image);
img1 = image(:, 1:width-2,:);
img2 = image(1:height-2, :,:);
gradX = zeros(size(image));
gradY = zeros(size(image));
for i = 1:3
    gradX(:, :, i) = conv2(img1(:,:,i), kernel);
    gradY(:, :, i) = conv2(img2(:,:,i), kernel');
end
Mxx = sum(gradX.^2, 3);
Mxy = sum(gradX.*gradY, 3);
Myy = sum(gradY.^2, 3);
eig = (Mxx + Myy + sqrt((Mxx + Myy).^2 - 4*(Mxx.*Myy - Myy.^2)))/2;
grad = atan((eig - Mxx)./ Mxy);
max(eig(:))
min(eig(:))
for i = 2:height-1
    for j = 2:width-1
        mat = eig(i + kernel, j + kernel);
        if max(mat(:)) < 1  
            eig(i, j) = 0;
        end
    end
end
for i = 2:height-1
    for j = 2:width-1
        mat = eig(i + kernel, j + kernel);
        temp = abs(mat - eig(i, j));
        if sum(mat(:)) - sum(temp(:)) > 0
            eig(i, j) = 0;
        end
    end
end

        
imshow(eig);