% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = testAgent(a,NN)
pos = zeros(4);
res = -2;
i=0;
while res<-1
    
    if i>15
        res = 0;
    else
        if mod(i,2) == 0
            disp('My turn');
            inx = makeMove(a,pos,NN);
            pos(inx(1),inx(2)) = 1;
            res = eval_pos(pos);
            i = i+1;
        else
            inx = input('Your turn:');
            pos(inx) = -1;
            res = eval_pos(pos);
            i = i+1;
        end
    end
    showBoard(pos);
end
end