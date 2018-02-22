function [ clusters ] = chopTree( clusterTree, height, frameCount, frameDiff)
%CHOPTREE :this function cuts the tree at some level and returns the
%clusters generated
%   Input Arguments :
%   clusterTree : the cluster tree returned by linkage(hierarchical clust)
%   height : this specifies height for cutting the tree wrt max height
%   frameCount : this represents total number of frames in each set
%                 for training the HMM
%   frameDiff : this represents, at how much diff, the frame seqs are taken
%   Output Arguments :
%
%frameCount = 20;
num = size(clusterTree, 1);
tmp = 1:2*num + 1;
tmp = tmp';
tree = zeros(num + 1, 3);
tree = [tree;clusterTree];
clusterTree = [tmp tree];
clusterTree
indx = clusterTree(:,1);
root = max(indx);
dist = clusterTree(:,4);
cutDist = max(clusterTree(:,4))/height;
while(1)
    len = length(root);
    modify = 1;
    for i = 1:len
        if i > length(root)
            break
        end
        
        if(dist(indx == root(i)) > cutDist) %find the cluster distance at this node
            fprintf('Splitting the node %d.\n', root(i));
            modify = 0;
            in = find(indx == root(i));
            root(i) = [];
            root = [root clusterTree(in,2) clusterTree(in,3)];
        end
    end
    if modify
        break;
    end
end
root
numClusters = length(root);
if numClusters < 6
    fprintf('Number of clusters(%d) are less than 6.'...
        + 'Try increasing the value of height \n',numClusters);
elseif numClusters > 8
    fprintf('Number of clusters(%d) are more than 8.'...
        + 'Try decreasing the value of height \n',numClusters);
end
%get the subtree coresponding to the nodes in the tree
clusters = cell(numClusters,1);
file = fopen('frameCluster.txt', 'w');
for i = 1:numClusters 
    subRoot = root(i);
    while(~isempty(subRoot))
        n = length(subRoot);
        for j = 1:n
            if j > length(subRoot)
                break;
            end
            in = indx == subRoot(j);
            if(clusterTree(in, 2) == 0) %clusterTree(in,3) will also b 0 here
                clusters{i} = [clusters{i} subRoot(j)];
                subRoot(j) = [];
            else
                subRoot(j) = [];
                subRoot = [subRoot clusterTree(in,2) clusterTree(in,3)]; 
            end
        end
    end
    cl = sort(clusters{i});
    for j = 1:length(cl)
        fprintf(file,'%d:%d\t\t',frameDiff*cl(j),frameDiff*cl(j) + frameCount);
    end
    fprintf(file, '\n');
end
fclose(file)
copyfile('frameCluster.txt', '../../cs499/videoInfo/coaxing/frameCluster.txt');
end

