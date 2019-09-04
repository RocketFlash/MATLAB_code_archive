% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = randMut(param)
    r = rand();
    res = 0;
    if r<param.mutFactor
        res = res + rand();
    end
    if r<(param.mutFactor^2)
        res = res + rand()*10;
    end
    if r<(param.mutFactor^3)
        res = res + rand()*100;
    end
    if r<(param.mutFactor^4)
        res = res + rand()*1000;
    end
end