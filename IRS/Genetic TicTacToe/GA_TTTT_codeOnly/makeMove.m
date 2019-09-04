% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = makeMove(ag, pos, NN) 
    maxEstim = -10000;
    for i=1:4
        for j=1:4
            if pos(i,j)==0
                pos1 = pos;
                pos1(i,j)= 1;
                estim = NeuralNetwork(ag,pos1,NN);
                if estim>maxEstim
                    max = [i,j];
                    maxEstim = estim;
                end
            end
        end
    end
    
    res = max;
end