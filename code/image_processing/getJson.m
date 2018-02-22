function [] = getJson(clusterTree)
num = size(clusterTree,1);
tmp = 1:2*num + 1;
tmp = tmp';
%set(0, 'RecursionLimit', 1000);
fp = fopen('file.txt', 'w');
tree = zeros(num + 1, 3);
tree = [tree;clusterTree];
tree = [tmp tree];
str = printJson(tree, 2*num+1, num + 1);
fprintf(fp, '%s', str);
fclose(fp);
fp = fopen('newFile.txt', 'w');
indexArr = cell(2*num +1, 1);
fprintf(fp, '[');
for i = 1:num+1
    indexArr{i} = i;
    fprintf(fp,'[%d], \n', i);
end
tree
for i = (num + 2):2*num+1
    indexArr{i} = [indexArr{tree(i, 2)} indexArr{tree(i, 3)}];
    indexArr{i} = uint32(indexArr{i});
    len = length(indexArr{i});
    t = indexArr{i};
    fprintf(fp, '[');
    for j = 1:len-1
        fprintf(fp, '%d, ',t(j)); 
    end
    fprintf(fp, '%d ]',t(len));
    if(i < 2*num + 1)
        fprintf(fp, ',');
    end
    fprintf(fp, '\n');
end
fprintf(fp, ']');
fclose(fp);
end

function [str] = printJson(tree, index, num)

 if(index <=num)
     str = ['{' 'id: "node' num2str(index) '", name: "' num2str(index) '..' num2str(tree(index, 4)) ...
        '", data: {}, ' 'children: []}' ];
 else
    str = ['{' 'id: "node' num2str(index) '", name: "' num2str(index) '..' num2str(tree(index, 4)) ...
        '", data: {}, ' 'children: [' printJson(tree, tree(index, 2), num)...
        ' , ' printJson(tree, tree(index, 3), num) ']}'];
 end
 %}
end