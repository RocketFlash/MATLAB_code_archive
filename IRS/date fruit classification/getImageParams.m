% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

%this function returns meaningful features from the date pictures
function params = getImageParams(IMAGE)
% convert a color image to black and white
    IMAGEBW = ~im2bw(IMAGE);
% remove non of dates the extra points 
    IMAGEBW = bwareaopen(IMAGEBW,6000);
% red, green and blue channels
    red = IMAGE(:,:,1);
    green = IMAGE(:,:,2);
    blue = IMAGE(:,:,3);
% measure properties of image regions
    s = regionprops(IMAGEBW, 'Orientation', 'MajorAxisLength', ...
        'MinorAxisLength', 'Eccentricity', 'Centroid','Area','Perimeter');
% meaningful features:
% mean value in each color channel
    meanR = mean2(red(IMAGEBW));
    meanG = mean2(green(IMAGEBW));
    meanB = mean2(blue(IMAGEBW));
% standard deviation
    stdR = std2(red(IMAGEBW));
    stdG = std2(green(IMAGEBW));
    stdB = std2(blue(IMAGEBW));
    
    area = s(1).Area;
    perimeter = s(1).Perimeter;
    eccentricity = s(1).Eccentricity;
    majorLength = s(1).MajorAxisLength;
    minorLength = s(1).MinorAxisLength;
% entropy and energy of image channels
    entropyR = entropy(red(IMAGEBW));
    entropyG = entropy(green(IMAGEBW));
    entropyB = entropy(blue(IMAGEBW));

    enR = graycoprops(red,'Energy');
    enG = graycoprops(green,'Energy');
    enB = graycoprops(blue,'Energy');
    energyR = enR.Energy;
    energyG = enG.Energy;
    energyB = enB.Energy;
    
    params = [meanR,meanG,meanB,...
              stdR,stdG,stdB,...
              area,perimeter,eccentricity,...
              majorLength,minorLength,...
              entropyR,entropyG,entropyB,...
              energyR,energyG,energyB];
    
end

