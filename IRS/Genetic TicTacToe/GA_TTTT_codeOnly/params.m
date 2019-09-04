% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

% parametrization
function res = params()

param.numberOfAgents = 150;

param.numberOfGenerations = 100;

param.fieldSize = 4;
param.cellsCount = param.fieldSize^2;
param.newronsNumber = 10;
param.layersNumber = 2;
param.genomeSize = 2*param.cellsCount*param.newronsNumber +param.newronsNumber + param.cellsCount + (param.layersNumber-1)*param.newronsNumber*(param.newronsNumber+1);
%p(2*n^2+m-1)
param.NN = [param.layersNumber,param.newronsNumber];

param.deathFactor = 70;
% 10-100, default 50

param.crossoverFactor = 200;
%probability of crossover between each genes. default - 100 (1/100)

param.factor = 0.25;
%weight of winning-losing. shows the "speed" of discrimination in
%population by "playing skills"

param.mutFactor = 0.2;


res = param;
end