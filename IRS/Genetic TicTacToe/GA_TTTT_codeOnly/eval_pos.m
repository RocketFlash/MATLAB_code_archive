% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = eval_pos(pos)
    res = -2;    
    pos2 = [pos,pos',diag(pos),diag(flipud(pos))];
    pos3 = [1,1,1,1]*pos2;
    if max(pos3)==length(pos)
        res=1;
    end
    if min(pos3)==-length(pos)
        res=-1;
    end
end