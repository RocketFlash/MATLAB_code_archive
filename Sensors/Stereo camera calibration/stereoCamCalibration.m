function stereoCamCalibration()
numImagePairs = 20;

imageFiles1 = cell(numImagePairs, 1);
imageFiles2 = cell(numImagePairs, 1);

for i = 1:numImagePairs
    imageFiles1{i} = fullfile('left',sprintf('%dl.bmp', i));
    imageFiles2{i} = fullfile('right',sprintf('%dr.bmp', i));
end

images1 = cast([], 'uint8');
images2 = cast([], 'uint8');
for i = 1:numel(imageFiles1)
    im = imread(imageFiles1{i});
    images1(:, :, :, i) = im;

    im = imread(imageFiles2{i});
    images2(:, :, :, i) = im;
end

[imagePoints, boardSize] = detectCheckerboardPoints(images1, images2);

% Display one masked image with the correctly detected checkerboard
subplot(3,2,1);
imshow(images1(:,:,:,1), 'InitialMagnification', 50);
hold on;
plot(imagePoints(:, 1, 1, 1), imagePoints(:, 2, 1, 1), '*-g');
title('Successful Checkerboard Detection');

% Generate world coordinates of the checkerboard points.
squareSize = 35; % millimeters
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Compute the stereo camera parameters.
stereoParams = estimateCameraParameters(imagePoints, worldPoints);

% Evaluate calibration accuracy.
subplot(3,2,2);
showReprojectionErrors(stereoParams);

% Read in the stereo pair of images.
I1 = imread('13l.bmp');
I2 = imread('13r.bmp');

% Rectify the images.
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);

subplot(3,2,3:4);
imshowpair(stereoAnaglyph(I1, I2),stereoAnaglyph(J1, J2), 'montage');
title('Before Rectification(left) & After Rectification(right)');

disparityRange = [0, 64];
disparityMap = disparity(rgb2gray(J1), rgb2gray(J2), 'DisparityRange', ...
    disparityRange);
subplot(3,2,5);
imshow(disparityMap, disparityRange, 'InitialMagnification', 50);
colormap('jet');
colorbar;
title('Disparity Map');

point3D = reconstructScene(disparityMap, stereoParams);

% Convert from millimeters to meters.
point3D = point3D / 1000;

% Plot points between 3 and 7 meters away from the camera.
z = point3D(:, :, 3);
z = -z;
maxZ = 3;
minZ = 1;
zdisp = z;
zdisp(z < minZ | z > maxZ) = NaN;
point3Ddisp = point3D;
point3Ddisp(:,:,3) = zdisp;
subplot(3,2,6);
pcshow(point3Ddisp, J1, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down' );
title('3D model');
xlabel('X');
ylabel('Y');
zlabel('Z');
end
