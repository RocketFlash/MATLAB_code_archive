function calibration()
close all

% Number of input images
numImages = 15;
magnification = 50;
files = cell(1, numImages);

for i = 1:numImages
    files{i} = fullfile(sprintf('jpg%d.jpg', i));
end

% Detect the checkerboard corners in the images.
[imagePoints, boardSize] = detectCheckerboardPoints(files);

% Generate the world coordinates of the checkerboard corners in the
% pattern-centric coordinate system, with the upper-left corner at (0,0).
squareSize = 23; % in millimeters
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera.
cameraParams = estimateCameraParameters(imagePoints, worldPoints);

% Evaluate calibration accuracy.
figure; showReprojectionErrors(cameraParams);
title('Reprojection Errors');

imOrig = imread(fullfile('image15.jpg'));
[im, newOrigin] = undistortImage(imOrig, cameraParams);
figure;subplot(2,1,1);
imshowpair(imOrig,im,'montage');
title('Original Image (left) vs. Corrected Image (right)');

% Convert the image to the HSV color space.
imHSV = rgb2hsv(im);

% Get the saturation channel.
saturation = imHSV(:, :, 2);

% Threshold the image
t = graythresh(saturation);
imCoin = (saturation > t);

% Find connected components.
blobAnalysis = vision.BlobAnalysis('AreaOutputPort', true,...
    'CentroidOutputPort', false,...
    'BoundingBoxOutputPort', true,...
    'MinimumBlobArea', 300, 'ExcludeBorderBlobs', true);
[areas, boxes] = step(blobAnalysis, imCoin);

% Sort connected components in descending order by area
[~, idx] = sort(areas, 'Descend');

% Get the largest component.
boxes = double(boxes(idx(1), :));

% Adjust for coordinate system shift caused by undistortImage
boxes(:, 1:2) = bsxfun(@plus, boxes(:, 1:2), newOrigin);

% Reduce the size of the image for display.
scale = magnification / 100;
imDetectedCoins = imresize(im, scale);

imDetectedCoins = insertObjectAnnotation(imDetectedCoins, 'rectangle', ...
    scale * boxes, 'thing');
imDetectedCoins = imresize(imDetectedCoins, 100/magnification);
subplot(2,1,2);
imshowpair(imCoin,imDetectedCoins,'montage');
title('Saturated image(left), found box (right)');


% Detect the checkerboard.
[imagePoints, boardSize] = detectCheckerboardPoints(im);

% Compute rotation and translation of the camera.
[R, t] = extrinsics(imagePoints, worldPoints, cameraParams);

% Get the top-left and the top-right corners.
box1 = double(boxes(1, :));
imagePoints1 = [box1(1:2); ...
                box1(1) + box1(3), box1(2)-box1(4)];

% Get the world coordinates of the corners
worldPoints1 = pointsToWorld(cameraParams, R, t, imagePoints1);

% Compute thing sizes in millimeters.
widthOfThing = worldPoints1(2, 1) - worldPoints1(1, 1);
heightOfThinf = worldPoints1(1, 2) - worldPoints1(2, 2);


fprintf('Measured width of the thing = %0.2f mm\n', widthOfThing);
fprintf('Measured height of the thing = %0.2f mm\n', heightOfThinf);

% Compute the center of the thing.
center1_image = box1(1:2) + box1(3:4)/2;

% Convert to world coordinates.
center1_world  = pointsToWorld(cameraParams, R, t, center1_image);

% Remember to add the 0 z-coordinate.
center1_world = [center1_world 0];

% Compute the distance to the camera.
distanceToCamera = norm(center1_world + t);
fprintf('Distance from the camera to the thing = %0.2f mm\n', ...
    distanceToCamera);

end