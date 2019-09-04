function Position = NeuralNetwork(Board, Agent)

%number of hidden layers
numberOfHiddenLayers = 1;
%number of neurons in each hidden layer
numberOfNeurons = 10; 

currentLayer = Board(:)';
t = 1;
teta = 0.5;

for j = 1:numberOfHiddenLayers
    X = [1, currentLayer(1,:)];
    newLayer = zeros(1,numberOfNeurons); 
    for i = 1:numberOfNeurons
        W = Agent(t:t+length(X)-1);
        newLayer(i) = dot(X,W);
        t = t + length(X)+1;
    end
    newLayer = sigmoid(newLayer,1);
    currentLayer = newLayer;
end

X = [1, currentLayer(1,:)];
answers = zeros(1,length(Board));
for i = 1:length(Board(:))
        W = Agent(t:t+length(X)-1);
        if Board(i)~=0
            answers(i) = 0;
        else
            answers(i) = dot(X,W);
        end
        t = t + length(X)+1;
end
answers = softmax(answers);

[m,inx] = max(answers);
disp(answers)
disp(sum(answers))
Position = Board
turnX = sum(Board(:) == 1);
turnO = sum(Board(:) == -1);
disp(turnX)
disp(turnO)

if turnX == turnO
    Position(inx) = 1;
elseif turnX > turnO
    Position(inx) = -1;    
end

end

