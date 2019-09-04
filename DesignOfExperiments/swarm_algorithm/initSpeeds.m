%initialization of speeds of the swarm
%inputs:
%swarmSize - size of swarm population
%numParams - number of dimentions for optimization
%lb - vector of lower bounds for each parameter
%     lb = [lb_1,lb_2, ... lb_numParams]
%ub - vector of lower bounds for each parameter
%     ub = [ub_1,ub_2, ... ub_numParams]
%output:
%speeds - matrix of positions
%        speeds = [s1_1, s1_2, ... ... ... ... s1_numParams]
%                 [... ... ... ... ... ... ... ... ... ... ]
%                 [sswarmSize_1 .....  sswarmSize_numParams]

function speeds = initSpeeds(swarmSize,numParams,lb,ub)
r = rand(swarmSize, numParams);
minVal = -(ub-lb);
maxVal =  (ub-lb);
lbm = repmat(minVal,swarmSize,1);
ubm = repmat(maxVal,swarmSize,1);
speeds = (r.*(ubm-lbm) + lbm)./10;
end

