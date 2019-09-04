function [scores,best,indx] = calculateScores(fun,swarm,Pi,lb,ub)
swarmSize = size(swarm,1);
scores = zeros(swarmSize,1);

for i=1:swarmSize
    swrm = swarm(i,:);
    ot1 = find(swrm<lb);
    ot2 = find(swrm>ub);
    penalty1 = sum(abs(swrm(ot1) - lb(ot1)).*100000000);
    penalty2 = sum(abs(swrm(ot2) - ub(ot2)).*100000000);
%     scores(i) = sumJacobians_7DOF(swrm,Pi) + penalty1 + penalty2;
    scores(i) = fun(swrm,Pi)+penalty1+penalty2;
end

[best,indx]= min(scores);
end

