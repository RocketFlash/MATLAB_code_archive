%initialization of positions of the swarm
%inputs:
%swarmSize - size of swarm population
%numParams - number of dimentions for optimization
%lb - vector of lower bounds for each parameter
%     lb = [lb_1,lb_2, ... lb_numParams]
%ub - vector of lower bounds for each parameter
%     ub = [ub_1,ub_2, ... ub_numParams]
%output:
%positions - matrix of positions
%     positions = [p1_1, p1_2, ... ... ... ... p1_numParams]
%                 [... ... ... ... ... ... ... ... ... ... ]
%                 [pswarmSize_1 .....  pswarmSize_numParams]
function [positions,globalBest,localBests,scores,bestScore] = initPositions(fun,swarmSize,numParams,lb,ub,Pi)
r = rand(swarmSize, numParams);
lbm = repmat(lb,swarmSize,1);
ubm = repmat(ub,swarmSize,1);
positions = r.*(ubm-lbm) + lbm;

[scores,bestScore, idx] = calculateScores(fun,positions,Pi,lb,ub);
globalBest = positions(idx,:);
localBests = positions;

end

