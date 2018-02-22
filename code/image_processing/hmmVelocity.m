close all;
fileName = 'plots/coaxData.txt';
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
centroidOne(:,2) = 240 - centroidOne(:, 2) + 1;
centroidTwo(:,2) = 240 - centroidTwo(:, 2) + 1;
%the velocity of the two triangles will be calculated by previous 2 frames
%and next two frames
% TRIANGLE ONE
%velocity calculated based on position change in next frame
velOne_1 = [centroidOne(2:end,:) - centroidOne(1:end-1, :); ...
            centroidOne(end, :)];

%velocity calculated based on position change in next 2 frames
velOne_2 = [centroidOne(3:end, :) - centroidOne(1:end-2, :);...
            centroidOne(end-1:end, :)]/2;
%velocity calculated based on position change in last frame
velOne1  = [centroidOne(1, :); centroidOne(1:end-1, :) - ...
            centroidOne(2:end, :)];

%velocity calculated based on position change in last two frames
velOne2  = [centroidOne(1:2, :); centroidOne(1:end-2, :) - ...
            centroidOne(3:end, :)]/2;
%TRIANGLE TWO

velTwo_1 = [centroidTwo(2:end,:) - centroidTwo(1:end-1, :); ...
            centroidTwo(end, :)];

velTwo_2 = [centroidTwo(3:end, :) - centroidTwo(1:end-2, :);...
            centroidTwo(end-1:end, :)]/2;

velTwo1  = [centroidTwo(1, :); centroidTwo(1:end-1, :) - ...
            centroidTwo(2:end, :)];
        
velTwo2  = [centroidTwo(1:2, :); centroidTwo(1:end-2, :) - ...
            centroidTwo(3:end, :)]/2;
        
velOne = (velOne_1 + velOne_2 + velOne1 + velOne2)/4;
velTwo = (velTwo_1 + velTwo_2 + velTwo1 + velTwo2)/4;
firstFeature  = sum((centroidTwo - centroidOne).*(velTwo - velOne), 2);
secondFeature  = sum((centroidTwo - centroidOne).*(velTwo + velOne), 2);
thirdFeature = areVisible(2, 'coax');
inputVector = [firstFeature secondFeature thirdFeature];
frameCount = 20;
frameDifference = 10;

fprintf('Calculating HMM for %d frames with %d frames at a time and %d frame difference\n', numData, frameCount, frameDifference);
numHmm = round((numData - frameCount)/frameDifference) + 2;
logLik = zeros(numHmm, 1);
count = 1;
c1 = 1;
%inputVector = 100*normalize(inputVector);
for i = 1:frameDifference:numData
    j = i + frameCount - 1;
    if j > numData
	break;
        j = numData;
    end
    inputData = inputVector(i:j, :);
	inputData = inputData';
	%inputData = 100*normalize(inputData);
    test = inputData - min(inputData(:));
    inputData = (1*test)/max(test(:));
	%inputData = (inputData)/norm(inputData);
    O = size(inputData, 1);
	Q = 3;
	M = 1;
	cov_type = 'full';
	prior0 = normalise(rand(Q,1));
	transmat0 = mk_stochastic(rand(Q,Q));
	[mu0 sigma0] = mixgauss_init(Q*M, inputData, cov_type); 
	mu0= reshape(mu0,[O Q M]);
	sigma0 = reshape(sigma0, [O O Q M]);
	mixmat0 = mk_stochastic(rand(Q,M));
    [LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
		mhmm_em(inputData, prior0, transmat0, mu0, ...
        sigma0, mixmat0, 'max_iter', 5);
     c2 = 1;
	for k = 1:frameDifference:numData
		ml  = k + frameCount - 1;
		if ml > numData
			break;
		end
		tmp = inputVector(k:ml, :);
		%tmp = 100*normalize(tmp);
		tmp1 = tmp - min(tmp(:));
        tmp = (1*tmp1)/max(tmp1(:));
        loglik = mhmm_logprob(tmp', prior1, transmat1, mu1, ...
			Sigma1, mixmat1);
		hmmDist(count, c2) = loglik/frameCount;
		c2 = c2 + 1;
	end
	
	loglik = mhmm_logprob(inputData, prior1, transmat1, mu1, ...
        Sigma1, mixmat1);
	
    logLik(count) = loglik/(j-i);
    count = count + 1;
end
%error('stop');
len1 = count - 1;
dstnce = [];
for i = 1:len1
	for j = i+1:len1
		dstnce = [dstnce abs(hmmDist(i, j) + hmmDist(j, i))];
	end
end
figure;
clusterTree = linkage(dstnce, 'ward'); %@distanceHMM
clusterTree
[h T]= dendrogram(clusterTree);
disp('program paused');
pause
getJson(clusterTree);
numPoints = 10;
print(gcf,'-dpng','coax/dendoVelocity.png');

pointData = [];
for i = 1:numPoints
    tmp = find(T==i);
    %fprintf('Cluster %d contains...\n', i);
    val = [(tmp -1)*frameDifference (tmp -1)*frameDifference ...
        + frameCount-1] + triangleData(1,1);
    mVal = mean(val, 2);
    pointData = [pointData ; [mVal i*ones(size(mVal))]];
end
f2 = figure('visible', 'off'); hold on;
plot(pointData(:,1), pointData(:,2),'bo');
print(f2, '-dpng', 'coax/clusterVelocity.png');