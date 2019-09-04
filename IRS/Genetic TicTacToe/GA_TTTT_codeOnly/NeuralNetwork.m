% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function answer = NeuralNetwork( Ag,pos,NN)
Board = posOptimizer(pos);
%optimal flipping of position
Agent = agentNorm(Ag);
%number of hidden layers
numberOfHiddenLayers = NN(1);
%number of neurons in each hidden layer
numberOfNeurons = NN(2); 
currentLayer = Board(:)';
t = 1;
for j = 1:numberOfHiddenLayers
    X = [1, currentLayer(1,:)];
    newLayer = zeros(1,numberOfNeurons); 
    for i = 1:numberOfNeurons
        W = Agent(t:t+length(X)-1);
        newLayer(i) = dot(X,W);
        t = t + length(X);
    end
    newLayer = sigmoid(newLayer,1);
    currentLayer = newLayer;
end

W = Agent(t:t+length(currentLayer)-1);
answer = dot(currentLayer,W);


end

function res = agentNorm (ag)
res = (1:size(ag,3));
for i=1:size(ag,3)    
    res(i) = (ag(1,1,i)+ag(1,2,i))/2;
end
end

function y = sigmoid(x,t)
X = 1+exp(-t*x);
y = 1./X;
end