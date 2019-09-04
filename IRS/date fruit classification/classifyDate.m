% Yagfarov Rauf
% Mamakov Timur
% Innopolis University


function dateclass = classifyDate(Image)
    params = getImageParams(Image);
    prob = myNeuralNetworkFunction(params);
    class = round(prob);
    dateclass = find(class);
end

