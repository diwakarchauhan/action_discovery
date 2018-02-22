function [videoFeatures] = removeDuplicate(videoFeatures)

count = 1;
i = 1;
while(i < size(videoFeatures))
    if(videoFeatures(i, :) == videoFeatures(i+1, :))
        videoFeatures(i+1, :) = [];
        continue;
    else
        count = count + 1;
        i = i + 1;
    end
    
end

end