%function [] = calculateHmm()
close all;
fileName = 'plots/coaxData.txt';
triangleData = load(fileName);
%unTri = unique(triangleData(:, 2:13), 'rows');
%triangleData = [ones(size(unTri, 1), 1) unTri];
numData = size(triangleData, 1);
triangleOne = triangleData(:, 2:7);
triangleOneX = [triangleOne(:,1) triangleOne(:,3) triangleOne(:,5)];
triangleOneY = [triangleOne(:,2) triangleOne(:,4) triangleOne(:,6)];
triangleTwo = triangleData(:, 8:13);
triangleTwoX = [triangleTwo(:,1) triangleTwo(:,3) triangleTwo(:,5)];
triangleTwoY = [triangleTwo(:,2) triangleTwo(:,4) triangleTwo(:,6)];
centroidOne = round([mean(triangleOneX, 2), mean(triangleOneY, 2)]); 
centroidTwo = round([mean(triangleTwoX, 2), mean(triangleTwoY, 2)]);
State = 10; 
%10 freames used for one HMM
%{
distOne = sqrt(sum(centroidOne.^2, 2));
distTwo = sqrt(sum(centroidTwo.^2, 2));
h = figure; hold on;
plot(triangleData(:,1), distOne, 'b-');
plot(triangleData(:,1), distTwo, 'r-');
print(h,  '-dpng', 'chaseCentroidPlot.png');
hold off;
im = 255*ones(240, 360, 3);%imread('0046.png');
h = figure;
imshow(im);
hold on;
plot(1,1, 'x', 'LineWidth', 2,'color', 'red');
plot(triangleOneX(1, 1), triangleOneY(1, 1), 'x', 'LineWidth', 2,'color', 'red');
plot(triangleOneX(1, 2), triangleOneY(1, 2), 'x', 'LineWidth', 2,'color', 'green');
plot(triangleOneX(1, 3), triangleOneY(1, 3), 'x', 'LineWidth', 2,'color', 'blue');

%plot(triangleTwoX(1, :), triangleTwoY(1, :),  'LineWidth', 2,'color', 'green');
%plot(centroidOne(1, 1), centroidOne(1, 2), 'x', 'LineWidth', 2,'color', 'red');
%plot(changedCentroid(1,1), changedCentroid(1,2), 'x', 'LineWidth', 2, 'color', 'yellow');
%plot(1, 240, 'x', 'LineWidth', 2,'color', 'blue');
hold off;
%}
centroidOne(:,2) = 240 - centroidOne(:, 2) + 1;
centroidTwo(:,2) = 240 - centroidTwo(:, 2) + 1;
thetaOne = getOrientation(triangleOneX, triangleOneY, 'first');
thetaTwo = getOrientation(triangleTwoX, triangleTwoY, 'second');
%disp('program paused\n');
%pause;
%thetaOne = atan((centroidOne(:,2) - 1)./centroidOne(:, 1));
%thetaTwo = atan((centroidTwo(:,2) - 1)./centroidTwo(:, 1));
%visibility = areVisible(numData, 'drift');
%inputVector = [centroidOne thetaOne centroidTwo thetaTwo];% visibility];
inputVector = [centroidOne sin(thetaOne) cos(thetaOne) centroidTwo ...
                sin(thetaTwo) cos(thetaTwo)];
frameCount = 15;
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
    %fprintf('Length of the data %d \n', j-i);
    inputData = inputVector(i:j, :);
    %{
    states = 10; %states in the HMM model
    obsSymbol = 4; % observation symbols in the HMM model
    prior0 = normalise(rand(obsSymbol,1));
    transmat0 = mk_stochastic(rand(obsSymbol,obsSymbol));
    obsmat0 = mk_stochastic(rand(obsSymbol,states));
    [LL, prior1, transmat1, obsmat1] = dhmm_em(inputData, prior0, transmat0, obsmat0, 'max_iter', 5);
    loglik = dhmm_logprob(inputData, prior1, transmat1, obsmat1);
    logLik(count) = loglik;
    count = count + 1;
    %}
	inputData = inputData';
	inputData = 100*normalize(inputData);
    %test = inputData - min(inputData(:));
    %inputData = (1*test)/max(test(:));
	%inputData = (inputData)/norm(inputData);
    O = size(inputData, 1);
	Q = 2;
	M = 1;
	cov_type = 'full';
	prior0 = normalise(rand(Q,1));
	transmat0 = mk_stochastic(rand(Q,Q));
	[mu0 sigma0] = mixgauss_init(Q*M, inputData, cov_type); 
	mu0= reshape(mu0,[O Q M]);
	sigma0 = reshape(sigma0, [O O Q M]);
	mixmat0 = mk_stochastic(rand(Q,M));
	% {
    [LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
		mhmm_em(inputData, prior0, transmat0, mu0, ...
        sigma0, mixmat0, 'max_iter', 5);
    %}
    %{
    prior.mu = mu0;
	prior.Sigma = sigma0;
	
	[model logLikHist] = hmmFitEm(inputData', Q, 'gauss', 'verbose', true, ...
		'emissionPrior', prior, 'nRandomRestarts', 2, 'maxIter', 10);
	%'pi0', prior0','trans0',transmat0);
	%}
     c2 = 1;

	for k = 1:frameDifference:numData
		ml  = k + frameCount - 1;
		if ml > numData
			break;
		end
		tmp = inputVector(k:ml, :);
		tmp = 100*normalize(tmp);
		%tmp1 = tmp - min(tmp(:));
        %tmp = (1*tmp1)/max(tmp1(:));
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
clusterTree;
[h T]= dendrogram(clusterTree);
ct = chopTree(clusterTree, 17, frameCount, frameDifference);
disp('program paused');
pause
getJson(clusterTree);
numPoints = 10;
%close all;
%[H T] = dend(clusterTree, numPoints);
print(gcf,'-dpng','coax/dendo.png');
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
print(f2, '-dpng', 'coax/cluster.png');
maxVal = max(val(:));
%end