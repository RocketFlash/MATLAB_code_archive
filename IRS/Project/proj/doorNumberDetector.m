function [matchedBoxPoints, matchedScenePoints, inda] = doorNumberDetector(sceneImage, params)
scenePoints = detectSURFFeatures(sceneImage);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

numIm = length(params)-1;
bfbp = cell(1,numIm);
boxPairs = cell(1,numIm);
matchedBoxPoints = cell(1,numIm);
matchedScenePoints = cell(1,numIm);
a = ones(1,numIm);
c = ones(1,numIm);
for i = 1:numIm
    bfbp{i} = params{i+1};
    bb = bfbp{i};
    bf = bb{1};
    bp = bb{2};
    boxPairs{i} = matchFeatures(bf, sceneFeatures);
    matchedBoxPoints{i} = bp(boxPairs{i}(:, 1), :);
    matchedScenePoints{i} = scenePoints(boxPairs{i}(:, 2), :);
%     a(i) = size(matchedBoxPoints{i},1);
    c(i) = size(matchedScenePoints{i},1);
end

% [am, indc] = max(a);
[cm, inda] = max(c);
if cm==0
    inda = 0;
    matchedBoxPoints = 0;
    matchedScenePoints = 0;
else
    matchedBoxPoints = matchedBoxPoints{inda};
    matchedScenePoints = matchedScenePoints{inda};
end


end

