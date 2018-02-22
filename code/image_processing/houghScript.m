close all;
      standardImage = imread('0002.png');
      BW = standardImage - currentImage;
      BW = rgb2gray(BW);
      [a BW c]  = getShapes(BW, 0,0, 60);
      imwrite(BW, 'pic.jpg', 'jpg');
      [H,T,R] = hough(BW, 'RhoResolution',3);
      %BW = bwmorph(BW, 'thin', Inf);
      imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
      imshow(H,[],'XData',T,'YData',R);
      xlabel('\theta'), ylabel('\rho');
      axis on, axis normal, hold on;
      numLines = 3;
      P  = houghpeaks(H,numLines,'threshold',0.2*(max(H(:))), ...
          'NHoodSize', [49 49]);
      x = T(P(:,2)); 
      y = R(P(:,1));
      plot(x,y,'s','color','white');
       %for i = 1:numLines
        %   figure;
        %   imshow(c{i},[],'XData',T,'YData',R,'InitialMagnification','fit');
       %end
      % Find lines and plot them
      %lines = houghlines(BW,T,R,P, 'FillGap',fg,'MinLength',minl);
      h = figure; imshow(BW), hold on
      x1 = 1:360;
      yf = cell(numLines);
      for i = 1:numLines
          theta = x(i)*pi/180;
          y1 = round(y(i)/sin(theta) - x1*cot(theta));
          yf{i} = [y1' x1']; 
          plot(x1,y1, 'LineWidth', 1);
          %axis([1 360 1 360]);
      end
      vertex= zeros(3, 2);
      
      disp ('Calculating vertices of the triangle');
      for i = 1:3
          next = mod(i, 3) + 1;
          theta1 = x(i)*pi/180;
          theta2 = x(next)*pi/180;
          xVert = (y(i)*sin(theta2) - y(next)*sin(theta1))/(sin(theta2-theta1));
          yVert = (y(i)*cos(theta2) - y(next)*cos(theta1))/(sin(theta1-theta2));
          vertex(i, :) = round([xVert yVert]);
          assert(~isempty(vertex(i,:)));
      end
      % axis([240, 360, 240, 360])
      %hold off;
      %plot(v1(1),v1(2),'x','LineWidth',1,'Color','yellow');
      %plot(v2(1),v2(2),'x','LineWidth',1,'Color','red');
      %plot(v3(1),v3(2),'x','LineWidth',1,'Color','cyan');
      %for i = 1:numLines
      %      p1 = vertex(i, :);
      %      plot(p1(1), p1(2), 'x','LineWidth',3,'Color','yellow');
      % end
        pth = 'testimg.png';
        print(h, '-dpng', pth);
        
        cell1 = getTriangle(vertex(1,:), vertex(2, :), vertex(3, :), 3);
        tmpImg = BW;
        for i =1:3
            for j =1:size(cell1{i}, 1)
                tmp = cell1{i};
                tmp(tmp < 1) = 1;
                t1 = tmp(:,1);
                t1(t1>240) = 240;
                tmp(:,1) = t1;
                t1 = tmp(:,2);
                t1(t1>360) = 360;
                tmp(:,2) = t1;
                tmpImg(tmp(j,1), tmp(j,2)) = BW(tmp(j,1), tmp(j,2)) - BW(tmp(j,1), tmp(j,2));
            end
        end
        figure;
        imshow(tmpImg);
        %}


        %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%hough transform matlab code
        % plot beginnings and ends of lines
        %plot(xy(1,1),xy(1,2),'x','LineWidth',1,'Color','yellow');
        %plot(xy(2,1),xy(2,2),'x','LineWidth',1,'Color','red');

        % determine the endpoints of the longest line segment
        
      % highlight the longest line segment
      %plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
