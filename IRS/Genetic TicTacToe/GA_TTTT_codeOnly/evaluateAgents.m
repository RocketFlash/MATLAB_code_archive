% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = evaluateAgents(agents,param)
sizem = size (agents,1);
res = ones(sizem,1);
z = zeros(sizem);
for i=1:sizem
    parfor j=i+1:sizem
        tic = randi(2);
        if tic == 1
            z(i,j) = TTTT(agents(i,:,:),agents(j,:,:),param.NN);
        else
            z(i,j) = -TTTT(agents(j,:,:),agents(i,:,:),param.NN);
        end
    end
end
for i=1:sizem
    for j=i+1:sizem
        if z(i,j)==1
            res(i) = res(i)*(1+param.factor);
            res(j) = res(j)*(1-param.factor);
        end
        if z(i,j)==-1
            res(i) = res(i)*(1-param.factor);
            res(j) = res(j)*(1+param.factor);
        end
    end
end
end