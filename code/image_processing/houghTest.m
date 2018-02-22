function [BW vertex tmpImg P] = houghTest(BW, peakVal, numLines, pth, Previous) 
    if nargin < 2
        peakVal = 0.5;
    end
    if nargin < 3
        numLines = 3;
    end
 
close all;
      %standardImage = imread('0002.png');
      %BW = standardImage - currentImage;
      %BW = rgb2gray(BW);
      %[a BW c]  = getShapes(BW, 0,0, 60);
      imwrite(BW, 'pic.jpg', 'jpg');
      [H,T,R] = hough(BW, 'RhoResolution',2);
      %H = getNeighbourhood(H,Previous, [15 15]);
      %BW = bwmorph(BW, 'thin', Inf);
      %imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
      %imshow(H,[],'XData',T,'YData',R);
      %xlabel('\theta'), ylabel('\rho');
      %axis on, axis normal, hold on;
      
      
      P  = houghpeaks(H,numLines,'threshold',peakVal*(max(H(:))), ...
          'NHoodSize', [49 49]);
      x = T(P(:,2)); 
      y = R(P(:,1));
      fprintf('Number of peaks detected is %d\n', length(x));
      %plot(x,y,'s','color','white');
       %for i = 1:numLines
        %   figure;
        %   imshow(c{i},[],'XData',T,'YData',R,'InitialMagnification','fit');
       %end
      % Find lines and plot them
      %lines = houghlines(BW,T,R,P, 'FillGap',fg,'MinLength',minl);
      h = figure('visible', 'on'); imshow(BW), hold on
      x1 = 1:max(size(BW));
      yf = cell(numLines);
      for i = 1:numLines
          theta = x(i)*pi/180;
          y1 = round(y(i)/sin(theta) - x1*cot(theta));
          yf{i} = [y1' x1']; 
          plot(x1,y1, 'LineWidth', 1);
          %axis([1 360 1 360]);
      end
      vertex= zeros(numLines, 2);
      tmp = 0;
      disp ('Calculating vertices of the triangle');
      for i = 1:numLines
          next = mod(i+tmp, numLines) + 1 ;
          theta1 = x(i)*pi/180;
          theta2 = x(next)*pi/180;
          xVert = (y(i)*sin(theta2) - y(next)*sin(theta1))/(sin(theta2-theta1));
          yVert = (y(i)*cos(theta2) - y(next)*cos(theta1))/(sin(theta1-theta2));
          vertex(i, :) = round([xVert yVert]);
          assert(~isempty(vertex(i,:)));
      end
      % axis([240, 360, 240, 360])
      %hold off;
      vertex
      plot(vertex(1, 1),vertex(1, 2),'x','LineWidth',1,'Color','yellow');
      plot(vertex(2, 1),vertex(2, 2),'x','LineWidth',1,'Color','red');
      if(numLines > 2)
        plot(vertex(3, 1),vertex(3, 2),'x','LineWidth',1,'Color','cyan');
        if(numLines > 3)
            plot(vertex(4, 1),vertex(4, 2),'x','LineWidth',1,'Color','blue');
            t= round(mean(vertex(3:4, :)));
            t1 = round((t + vertex(3, :))/2);
            t2 = round((t + vertex(4, :))/2);
            t2(1,2) = t2(1,2);
            plot(t1(1,1), t1(1,2),'x','LineWidth',1,'Color','cyan');
            plot(t2(1,1), t2(1,2),'x','LineWidth',1,'Color','blue');
            fp = fopen('test.txt', 'w');
            fprintf(fp, '%d %d \n %d %d \n %d %d \n%d %d \n%d %d \n%d %d \n',...
                vertex(1, 1), vertex(1, 2),vertex(2, 1), vertex(2, 2),...
                vertex(3, 1), vertex(3, 2),vertex(4, 1), vertex(4, 2), t1(1,1), t1(1,2), t2(1,1), t2(1,2));
            fclose(fp);
        end
      end
      
      %for i = 1:numLines
      %      p1 = vertex(i, :);
      %      plot(p1(1), p1(2), 'x','LineWidth',3,'Color','yellow');
      % end
        %pth = 'testimg.png';
      print(h, '-dpng', pth);
        
        cell1 = getTriangle(vertex, 2);
        tmpImg = BW;
        diffTemp = zeros(size(BW)); 
        [height width] = size(BW);
        for i =1:size(cell1, 1)
            for j =1:size(cell1{i}, 1)
                tmp = cell1{i};
                tmp(tmp < 1) = 1;
                t1 = tmp(:,1);
                t1(t1>height) = height;
                tmp(:,1) = t1;
                t1 = tmp(:,2);
                t1(t1>width) = width;
                tmp(:,2) = t1;
                tmpImg(tmp(j,1), tmp(j,2)) = BW(tmp(j,1), tmp(j,2)) - BW(tmp(j,1), tmp(j,2));
                diffTemp(tmp(j,1), tmp(j,2)) = mod(diffTemp(tmp(j,1), tmp(j,2)), 255)+255 - BW(tmp(j,1), tmp(j,2));
            end
        end
        %tmpImg = diffTemp;
        %figure;
        %imshow(tmpImg);
        %}
end


        %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%hough transform matlab code
        % plot beginnings and ends of lines
        %plot(xy(1,1),xy(1,2),'x','LineWidth',1,'Color','yellow');
        %plot(xy(2,1),xy(2,2),'x','LineWidth',1,'Color','red');

        % determine the endpoints of the longest line segment
        
      % highlight the longest line segment
      %plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
%}