% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

% this function creates input and target matrices for training the neural network
function [inputMatrix,targetMatrix] = getInputMatrix()
    
    numberOfSamples = 15;
    numberOfClasses = 8;
    numberOfParams = 17;
    totalNumberOfImages = numberOfSamples*numberOfClasses;
    inputMatrix = zeros(totalNumberOfImages,numberOfParams);
    targetMatrix = zeros(totalNumberOfImages,numberOfClasses);
    k = 1;
    for i = 1:numberOfClasses
        for j = 1:numberOfSamples
            IMAGE = imread(fullfile(strcat(sprintf('%d/', i),sprintf('%d.jpg', j))));
            targetMatrix(k,i) = 1;
            inputMatrix(k,:) = getImageParams(IMAGE);
            k=k+1;
        end
    end

end

