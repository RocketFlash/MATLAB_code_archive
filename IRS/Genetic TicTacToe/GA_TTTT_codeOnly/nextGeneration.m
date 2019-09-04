% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = nextGeneration(par,param)
m = size(par,1);
res = zeros(param.numberOfAgents,2,param.genomeSize);
res(1:m,:,:)=par;
for i=(m+1):param.numberOfAgents
    res(i,:,:) = newAgent(par(randi(m),:,:),par(randi(m),:,:),param); 
end
end