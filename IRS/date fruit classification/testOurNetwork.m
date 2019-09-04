% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

% accuracy test function
function errNum = testOurNetwork()
    
    numberOfSamples = 15;
    numberOfClasses = 8;
    totalNumberOfImages = numberOfSamples*numberOfClasses;
    errNum=0;
    k = 1;
    for i = 1:numberOfClasses
        for j = 1:numberOfSamples
            IMAGE = imread(fullfile(strcat(sprintf('%d/', i),sprintf('%d.jpg', j))));
            class=classifyDate(IMAGE);
            if class~=i
                errNum = errNum+1;
            end
            k=k+1;
        end
    end
    disp('Total error rate:');
    ter = (errNum/totalNumberOfImages)*100;
    disp(strcat(num2str(ter),'%'));

end

