% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = newAgent(p1,p2,param)
res = p1;
chromP1 = randi(2);
chromP2 = randi(2);
for i=1:size(p1,3)
    res(1,1,i) = p1(1,chromP1,i)+randMut(param);
    res(1,2,i) = p2(1,chromP2,i)+randMut(param);
    z = randi(param.crossoverFactor);
    if z<3
        chromP1 = z;
    end
    z = randi(param.crossoverFactor);
    if z<3
        chromP2 = z;
    end
end
end