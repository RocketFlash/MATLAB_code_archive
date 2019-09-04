function plotImage(sceneImage,matchedBoxPoints, matchedScenePoints, c, sizes)
if size(matchedBoxPoints,1)>2 && size(matchedScenePoints,1)>2 && ~isempty(c)
    [tform, inlierBoxPoints, inlierScenePoints] = ...
        estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

    boxPolygon = [1, 1;...                           % top-left
            sizes(2), 1;...                 % top-right
            sizes(2), sizes(1);... % bottom-right
            1, sizes(1);...                 % bottom-left
            1, 1];                   % top-left again to close the polygon

    newBoxPolygon = transformPointsForward(tform, boxPolygon);
    clf
    imshow(sceneImage);
    hold on;
    line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', c);
    pause(0.1);
    hold off;
else
   imshow(sceneImage); 
end

end

