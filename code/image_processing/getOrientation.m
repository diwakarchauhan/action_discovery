function [orientation] = getOrientation(triangleDataX, triangleDataY, dir)
if(exist(dir, 'dir') == 0)
    mkdir(dir);
end
triangleDataY = 240 - triangleDataY + 1;
centroidData = [round(mean(triangleDataX, 2)) ...
    round(mean(triangleDataY, 2))];
%centroidData(:,2) = 240 - centroidData(:, 2) + 1;

dataLength = size(centroidData, 1);
diffX = triangleDataX - centroidData(: , 1)*ones(1, 3);
diffY = triangleDataY - centroidData(: , 2)*ones(1, 3);
slopeVertices = atan2(diffY, diffX);
slopeVertices = slopeVertices*180/pi;
slopeVertices = mod((slopeVertices+ 360), 360);
centroidData1 = [centroidData(2:dataLength, :); [centroidData(dataLength, :)]];
motion = centroidData1 - centroidData;
%motion = atan2(motion(:, 1),  motion(:, 2));
motion = atan2(motion(:, 2),  motion(:, 1));
motion = motion *180/pi;
motion = mod((motion + 360), 360);
orientation = zeros(dataLength, 1);
for i = 1:dataLength-1
        motionDirection = motion(i, :);
        if (motionDirection ~= Inf || motionDirection ~= -Inf)
            temp = min([abs([slopeVertices(i+1, :) - motionDirection]);...
                360 - abs([slopeVertices(i+1, :) - motionDirection])]);
            [minVal index] = min(temp);
            if( i >= 2)
                temp2 = min([abs(slopeVertices(i+1, :) - orientation(i));...
                360 - abs(slopeVertices(i+1, :) - orientation(i))]);
                [minVal index1] = min(temp2);
                if(index ~= index1)
                    %if(motionDirection ~= 0)
                        index = index1;
                    %end
                end
                
            end
            orientation(i + 1) = slopeVertices(i+1, index);
        end
        %{
        fig = figure('visible', 'on');
        imshow(zeros(240, 320));
        hold 'on';
        plot([triangleDataX(i+1, 1);triangleDataX(i+1, 2)], ...
            [triangleDataY(i+1, 1);triangleDataY(i+1, 2)], 'LineWidth', 1,'color', 'red');
        plot([triangleDataX(i+1, 2);triangleDataX(i+1, 3)], ...
            [triangleDataY(i+1, 2);triangleDataY(i+1, 3)], 'LineWidth', 1,'color', 'green');
        plot([triangleDataX(i+1, 3);triangleDataX(i+1, 1)], ...
            [triangleDataY(i+1, 3);triangleDataY(i+1, 1)], 'LineWidth', 1,'color', 'blue');
        plot([centroidData(i+1, 1); triangleDataX(i+1, index)], ...
            [centroidData(i+1, 2); triangleDataY(i+1, index)], 'LineWidth', 1, 'color', 'cyan');
        plot(centroidData(i+1, 1), centroidData(i+1, 2), 'x');
        print(fig, '-dpng', [dir '/' num2str(i+1) '.png']);        
        %}
end
orientation(1) = orientation(2);
end